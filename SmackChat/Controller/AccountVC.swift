//
//  AccountVC.swift
//  SmackChat
//
//  Created by Steve Baker on 14/9/17.
//  Copyright © 2017 Steve Baker. All rights reserved.
//

import UIKit

class AccountVC: UIViewController {

    //outlets
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    
    //variables
    var avatarName = "profileDefault"
    var avatarColour = "[0.5, 0.5, 0.5, 1]"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    //IBActions
    @IBAction func cancelButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        guard let name = userName.text, userName.text != "" else { return }
        guard let email = emailTextField.text, emailTextField.text != "" else { return }
        guard let password = passwordTextField.text, passwordTextField.text != "" else { return }
        
        AuthService.instance.registerUser(email: email, password: password) { (success) in
            if success {
                print("success register")
                AuthService.instance.loginUser(email: email, password: password, completion: { (success) in
                    if success {
                        print("success login")
                        AuthService.instance.createUser(userName: name, avatarName: self.avatarName, avatarColour: self.avatarColour, email: email, completion: { (success) in
                            if success {
                                print("success user data service", UserDataService.instance.id, UserDataService.instance.userName)
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                            }
                        })
                    }
                })
            }
        }
    }
    
    @IBAction func avatarPressed(_ sender: Any) {
        performSegue(withIdentifier: AVATARVC, sender: nil)
    }
    
    @IBAction func generateColourPressed(_ sender: Any) {
        
    }
    
}
