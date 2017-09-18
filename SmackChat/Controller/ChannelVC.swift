//
//  ChannelVC.swift
//  SmackChat
//
//  Created by Steve Baker on 13/9/17.
//  Copyright © 2017 Steve Baker. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //Outlets
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var profileImage: CircleImage!
    @IBAction func prepeareForUnwind(segue: UIStoryboardSegue) {}
    @IBOutlet weak var channelTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        channelTable.delegate = self
        channelTable.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataUpdate(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.reloadChannelData(_:)), name: NOTIF_CHANNELS_RELOAD, object: nil)
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        
        SocketService.instance.obeserveChannel { (success) in
            if success {
                self.channelTable.reloadData()
            }
        }
 
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkUserInfo()
      
    }
    
    func checkUserInfo() {
        if AuthService.instance.loggedIN {
            loginButton.setTitle(UserDataService.instance.userName, for: .normal)
            profileImage.image = UIImage(named: UserDataService.instance.avatarName)
            profileImage.backgroundColor = UserDataService.instance.getImageColour(elements: UserDataService.instance.avatarColour)
        } else {
            loginButton.setTitle("Login", for: .normal)
            profileImage.image = UIImage(named: "menuProfileIcon")
            profileImage.backgroundColor = UIColor.clear
            channelTable.reloadData()
        }
    }
    
    @objc func userDataUpdate(_ notification: Notification) {
        checkUserInfo()
    }
    
    @objc func reloadChannelData(_ notification: Notification) {
        channelTable.reloadData()
    }
    
    //table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = channelTable.dequeueReusableCell(withIdentifier: "ChannelCell", for: indexPath) as? ChannelCell {
            let channel = MessageService.instance.channels[indexPath.row]
            cell.configCell(channel: channel)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let channel = MessageService.instance.channels[indexPath.row]
        MessageService.instance.selectedChannel = channel
        NotificationCenter.default.post(name: NOTIF_SELECTEDCHANNEL, object: nil)
        self.revealViewController().revealToggle(animated: true)
    }
    
    @IBAction func addChannelButtonPressed(_ sender: Any) {
        if AuthService.instance.loggedIN {
            let addChannelVC = AddChannelVC()
            addChannelVC.modalPresentationStyle = .custom
            present(addChannelVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        if AuthService.instance.loggedIN {
            let profileVC = ProfileVC()
            profileVC.modalPresentationStyle = .custom
            present(profileVC, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: LOGINVC, sender: nil)
        }
        
    }
    
    
    
}
