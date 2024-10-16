//
//  ViewController.swift
//  LupoSnapchat
//
//  Created by Rodrigo Diegojosue Lupo Cruz on 16/10/24.
//

import UIKit
import FirebaseAuth
class IniciarSesionViewController: UIViewController {
    
    @IBOutlet weak var usuariotxt: UITextField!
    @IBOutlet weak var contrasenatxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
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
    

}

