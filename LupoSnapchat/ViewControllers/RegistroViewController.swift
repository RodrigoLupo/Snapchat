import UIKit
import Firebase

class RegistroViewController: UIViewController {

    @IBOutlet weak var correotxt: UITextField!
    @IBOutlet weak var contrasenatxt: UITextField!
    @IBOutlet weak var confirmetxt: UITextField!
    @IBOutlet weak var crearbtn: UIButton!

    var email: String? // Propiedad para almacenar el email recibido

    override func viewDidLoad() {
        super.viewDidLoad()

        // Si el email fue pasado, rellenar el campo de texto
        if let emailRecibido = email {
            correotxt.text = emailRecibido
        }

        // Deshabilitar el botón de crear inicialmente
        crearbtn.isEnabled = false

        // Añadir observadores a los campos de contraseña y confirmación
        contrasenatxt.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        confirmetxt.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
    }

    // Función que se ejecuta cuando los campos de texto cambian
    @objc func textFieldsDidChange() {
        if contrasenatxt.text == confirmetxt.text && !contrasenatxt.text!.isEmpty {
            crearbtn.isEnabled = true // Habilitar el botón si las contraseñas coinciden
        } else {
            crearbtn.isEnabled = false // Deshabilitar el botón si no coinciden
        }
    }

    @IBAction func CrearUsuario(_ sender: Any) {
        guard let contrasena = contrasenatxt.text, contrasena == confirmetxt.text else {
            print("Las contraseñas no coinciden")
            return
        }

        // Crear el usuario en Firebase Authentication
        Auth.auth().createUser(withEmail: correotxt.text!, password: contrasena) { (user, error) in
            if let error = error {
                print("Error al crear el usuario: \(error.localizedDescription)")
            } else {
                print("Usuario creado exitosamente")
                
                // Guardar los datos del usuario en Firebase Database
                Database.database().reference().child("usuarios").child(user!.user.uid).child("email").setValue(user!.user.email)
                
                // Mostrar alerta confirmando la creación
                let alerta = UIAlertController(title: "Creación de Usuario", message: "Usuario: \(self.correotxt.text!) se creó correctamente.", preferredStyle: .alert)
                let btnOK = UIAlertAction(title: "Aceptar", style: .default, handler: { (UIAlertAction) in
                    // Redirigir al login
                    self.performSegue(withIdentifier: "login", sender: nil)
                })
                
                alerta.addAction(btnOK)
                self.present(alerta, animated: true, completion: nil)
            }
        }
    }
}
