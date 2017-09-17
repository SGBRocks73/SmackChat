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
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    
    //variables
    var avatarName = "profileDefault"
    var avatarColour = "[0.5, 0.5, 0.5, 1]"
    var backgroundColour: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            profileImage.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
            if avatarName.contains("light") && backgroundColour == nil {
                profileImage.backgroundColor = UIColor.lightGray
            }
        }
    }
    
    func setUpView() {
        activitySpinner.isHidden = true
        let attibutes = [NSAttributedStringKey.foregroundColor : SCPURPLE]
        userName.attributedPlaceholder = NSAttributedString(string: "username", attributes: attibutes)
        emailTextField.attributedPlaceholder = NSAttributedString(string: "email", attributes: attibutes)
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "password", attributes: attibutes)
        let tap = UITapGestureRecognizer(target: self, action: #selector(AccountVC.singleTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc func singleTap() {
        view.endEditing(true)
    }

    //IBActions
    @IBAction func cancelButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        activitySpinner.isHidden = false
        activitySpinner.startAnimating()
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
                                self.activitySpinner.isHidden = true
                                self.activitySpinner.stopAnimating()
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                                
                                //post notification
                                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
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
        let red = CGFloat(arc4random_uniform(255)) / 255
        let blue = CGFloat(arc4random_uniform(255)) / 255
        let green = CGFloat(arc4random_uniform(255)) / 255
        backgroundColour = UIColor(red: red, green: green, blue: blue, alpha: 1)
        avatarColour = "[\(red), \(green), \(blue), 1]"
        UIView.animate(withDuration: 0.2) {
            self.profileImage.backgroundColor = self.backgroundColour
        }
        
    }
    
}
