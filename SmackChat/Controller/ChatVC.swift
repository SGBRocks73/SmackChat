//
//  ChatVC.swift
//  SmackChat
//
//  Created by Steve Baker on 13/9/17.
//  Copyright © 2017 Steve Baker. All rights reserved.
//

import UIKit

class ChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Outlets
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var chatLabel: UILabel!
    @IBOutlet weak var chatText: UITextField!
    @IBOutlet weak var messageTable: UITableView!
    @IBOutlet weak var messageSendButton: UIButton!
    @IBOutlet weak var userTypingLabell: UILabel!
    
    //variables
    var isTyping = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        messageTable.delegate = self
        messageTable.dataSource = self
        messageTable.estimatedRowHeight = 80
        messageTable.rowHeight = UITableViewAutomaticDimension
        messageSendButton.isHidden = true
        
        menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        self.view.bindToKeyboard()
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVC.handleTap))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataUpdate(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_SELECTEDCHANNEL, object: nil)
        
        SocketService.instance.getMessage { (success) in
            if success {
                self.messageTable.reloadData()
                if MessageService.instance.messages.count > 0 {
                    let index = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
                    self.messageTable.scrollToRow(at: index, at: .bottom, animated: false)
                }
            }
        }
        
        SocketService.instance.getTyingUsers { (typingUsers) in
            guard let channelId = MessageService.instance.selectedChannel?.channelId else { return }
            var names = ""
            var typersCount = 0
            for (typers, channel) in typingUsers {
                if typers != UserDataService.instance.userName && channel == channelId {
                    if names == "" {
                        names = typers
                    } else {
                        names = "\(names), \(typers)"
                    }
                    typersCount += 1
                }
            }
            if typersCount > 0 && AuthService.instance.loggedIN == true {
                var verb = "is"
                if typersCount > 1 {
                    verb = "are"
                }
                self.userTypingLabell.text = "\(names) \(verb) typing...."
            } else {
                self.userTypingLabell.text = ""
            }
        }
        
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
            messageTable.reloadData()
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
                self.messageTable.reloadData()
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
    
    //messageTable
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = messageTable.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as? MessageCell {
            let message = MessageService.instance.messages[indexPath.row]
            cell.configureCell(message: message)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    
    @IBAction func checkUserTyping(_ sender: Any) {
        guard let chanelId = MessageService.instance.selectedChannel?.channelId else { return }
        if chatText.text == "" {
            isTyping = false
            messageSendButton.isHidden = true
            
            // data as per api code
            SocketService.instance.socket.emit("stopType", UserDataService.instance.userName, chanelId)
        } else {
            if isTyping == false {
                messageSendButton.isHidden = false
                SocketService.instance.socket.emit("startType", UserDataService.instance.userName, chanelId)
            }
            isTyping = true
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
                    SocketService.instance.socket.emit("stopType", UserDataService.instance.userName, channelId)
                    self.messageSendButton.isHidden = true
                }
            })
        }
    }
    


}
