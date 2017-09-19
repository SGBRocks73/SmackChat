//
//  ProfileVC.swift
//  SmackChat
//
//  Created by Steve Baker on 17/9/17.
//  Copyright © 2017 Steve Baker. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    //outlets
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        
    }
    
    func setUpView() {
        profileImage.image = UIImage(named: UserDataService.instance.avatarName)
        profileImage.backgroundColor = UserDataService.instance.getImageColour(elements: UserDataService.instance.avatarColour)
        email.text = UserDataService.instance.email
        userName.text = UserDataService.instance.userName
        let tap = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.tapScreen(_:)))
        backgroundView.addGestureRecognizer(tap)
    }
    
    @objc func tapScreen(_ recogniser: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        UserDataService.instance.logOutUser()
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editProfilePressed(_ sender: Any) {
        
    }
}
