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
    @IBOutlet weak var chatText: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        self.view.bindToKeyboard()
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVC.handleTap))
        view.addGestureRecognizer(tap)
        
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
    
    @objc func handleTap() {
        view.endEditing(true)
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
        getMessages()
    }
    
    func getMessages() {
        guard let channelId = MessageService.instance.selectedChannel?.channelId else { return }
        MessageService.instance.getAllMessages(channelId: channelId) { (success) in
            if success {
                
            }
        }
    }
    
    func onLogInGetMessages() {
        MessageService.instance.getAllChannels { (success) in
            if success {
                if MessageService.instance.channels.count > 0 {
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                    self.updateWithChannel()
                } else {
                    self.chatLabel.text = "No Channels yet"
                }
            }
        }
    }
    
    @IBAction func messageSentPressed(_ sender: Any) {
        if AuthService.instance.loggedIN {
            guard let channelId = MessageService.instance.selectedChannel?.channelId else { return }
            guard let message = chatText.text else { return }
            
            SocketService.instance.sendMessage(messageBody: message, userId: UserDataService.instance.id, channelId: channelId, completion: { (success) in
                if success {
                    self.chatText.text = ""
                    self.chatText.resignFirstResponder()
                }
            })
        }
    }
    


}
