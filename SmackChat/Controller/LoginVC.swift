//
//  LoginVC.swift
//  SmackChat
//
//  Created by Steve Baker on 14/9/17.
//  Copyright © 2017 Steve Baker. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    //outlets
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
    }
    
    func setUpView() {
        activitySpinner.isHidden = true
        let attibutes = [NSAttributedStringKey.foregroundColor : SCPURPLE]
        email.attributedPlaceholder = NSAttributedString(string: "email", attributes: attibutes)
        password.attributedPlaceholder = NSAttributedString(string: "password", attributes: attibutes)
    }
    
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createAccountButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: ACCOUNTVC, sender: nil)
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        activitySpinner.isHidden = false
        activitySpinner.startAnimating()
        
        guard let mail = email.text, email.text != "" else { return }
        guard let pass = password.text, password.text != "" else { return }
        
        AuthService.instance.loginUser(email: mail, password: pass) { (success) in
            if success {
                AuthService.instance.findUserByEmail(completion: { (success) in
                    if success {
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                        self.activitySpinner.stopAnimating()
                        self.activitySpinner.isHidden = true
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }
        }
        
    }
}
