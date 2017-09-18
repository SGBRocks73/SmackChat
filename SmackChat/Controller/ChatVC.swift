//
//  ChatVC.swift
//  SmackChat
//
//  Created by Steve Baker on 13/9/17.
//  Copyright © 2017 Steve Baker. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var chatLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataUpdate(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_SELECTEDCHANNEL, object: nil)
        
        if AuthService.instance.loggedIN {
            AuthService.instance.findUserByEmail(completion: { (success) in
                if success {
                    NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                }
            })
        }
        
    }
    
    @objc func userDataUpdate(_ notification: Notification) {
        if AuthService.instance.loggedIN {
            onLogInGetMessages()
        } else {
            chatLabel.text = "Please Login"
        }
    }
    
    @objc func channelSelected(_ notificatoin: Notification) {
        updateWithChannel()
    }
    
    func updateWithChannel() {
        let chatLabelText = MessageService.instance.selectedChannel?.channelTitle ?? ""
        chatLabel.text = "#\(chatLabelText)"
    }
    
    func onLogInGetMessages() {
        MessageService.instance.getAllChannels { (success) in
            if success {
                // do stuff here
            }
        }
    }



}
