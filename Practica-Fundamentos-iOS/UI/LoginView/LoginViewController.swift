//
//  LoginViewController.swift
//  Practica-Fundamentos-iOS
//
//  Created by David Robles Lopez on 26/12/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // don't make UI changes
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        emailTextField.center.x -= view.bounds.width
        passwordTextField.center.x -= view.bounds.width
        
        UIView.animate(withDuration: 2,                                                              // Con esto se le da animación a los textfield
                       delay: 0,
                       usingSpringWithDamping: 0.75,
                       initialSpringVelocity: 0,
                       options: []) {
            self.emailTextField.center.x += self.view.bounds.width
            self.passwordTextField.center.x += self.view.bounds.width
        }
        
        
    }
        
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty else {
            print("email is empty")
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {                             // Antes de llamar a la API se comprueba que no haya valores nulos
            print("password is empty")
            return
        }
        
        NetworkLayer.shared.login(email: email, password: password) { token, error in
            if let token = token {
                LocalDataLayer.shared.save(token: token)
               
                
                DispatchQueue.main.async {                                                               // Esto sirve para movernos desde el login al homeTabBarController
                    UIApplication
                        .shared
                        .connectedScenes
                        .compactMap{ ($0 as? UIWindowScene)?.keyWindow }
                        .first?
                        .rootViewController = HomeTabBarController()
                }
                
            }  else {
                        print("Login Error: ", error?.localizedDescription ?? "")
                    }
                }
            }
        }

