//
//  MessageCell.swift
//  SmackChat
//
//  Created by Steve Baker on 18/9/17.
//  Copyright © 2017 Steve Baker. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    
    //outlets
    @IBOutlet weak var userImage: CircleImage!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var messageBodyLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell(message: Message) {
        messageBodyLabel.text = message.message
        userImage.image = UIImage(named: message.userAvatar)
        userImage.backgroundColor = UserDataService.instance.getImageColour(elements: message.userAvatarColour)
        userNameLabel.text = message.userName
    }

}
