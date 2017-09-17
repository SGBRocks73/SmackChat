//
//  ChannelVC.swift
//  SmackChat
//
//  Created by Steve Baker on 13/9/17.
//  Copyright © 2017 Steve Baker. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var profileImage: CircleImage!
    @IBAction func prepeareForUnwind(segue: UIStoryboardSegue) {}
    

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataUpdate(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)

        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
    }
    
    @objc func userDataUpdate(_ notification: Notification) {
        if AuthService.instance.loggedIN {
            loginButton.setTitle(UserDataService.instance.userName, for: .normal)
            profileImage.image = UIImage(named: UserDataService.instance.avatarName)
            profileImage.backgroundColor = UserDataService.instance.getImageColour(elements: UserDataService.instance.avatarColour)
        } else {
            loginButton.setTitle("Login", for: .normal)
            profileImage.image = UIImage(named: "menuProfileIcon")
            profileImage.backgroundColor = UIColor.clear
        }
    }

    @IBAction func loginPressed(_ sender: Any) {
        performSegue(withIdentifier: LOGINVC, sender: nil)
    }
    
    
    
}
