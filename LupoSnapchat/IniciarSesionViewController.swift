//
//  ViewController.swift
//  LupoSnapchat
//
//  Created by Rodrigo Diegojosue Lupo Cruz on 16/10/24.
//
import GoogleSignIn
import UIKit
import FirebaseAuth
import FirebaseCore
import Firebase

class IniciarSesionViewController: UIViewController {
    
    @IBOutlet weak var usuariotxt: UITextField!
    @IBOutlet weak var contrasenatxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: FirebaseApp.app()?.options.clientID ?? "")
        // Do any additional setup after loading the view.
    }
    @IBAction func IniciarSesion(_ sender: Any) {
        Auth.auth().signIn(withEmail: usuariotxt.text!, password: contrasenatxt.text! ){ (user, error) in
            print("Intentando iniciar sesion")
            if error != nil{
                print("Se presento un error: \(error)")
            }else{
                print("Inicio de sesion exitoso")
            }
        }
    }
    @IBAction func IniciarGoogle(_ sender: Any) {
        // Iniciamos el proceso de Google Sign-In
                GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
                    if let error = error {
                        print("Error al iniciar sesión con Google: \(error.localizedDescription)")
                        return
                    }

                    // Verificamos que tengamos las credenciales correctas de Google
                    guard let user = signInResult?.user,
                          let idToken = user.idToken?.tokenString else {  // Eliminamos la cadena opcional
                        print("Error: No se pudo obtener el ID Token o Access Token.")
                        return
                    }
                    let accessToken = user.accessToken.tokenString

                    // Crea credenciales para Firebase con los tokens de Google
                    let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)

                    // Autentica al usuario en Firebase con las credenciales de Google
                    Auth.auth().signIn(with: credential) { authResult, error in
                        if let error = error {
                            print("Error al autenticar en Firebase: \(error.localizedDescription)")
                        } else {
                            print("Te autenticaste con Goolgle exitosamente!!!")
                            // Aquí podrías redirigir al usuario a la siguiente vista, si lo deseas
                        }
                    }
                }
            }
}

