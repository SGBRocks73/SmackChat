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

       
        guard var isoDate = message.timestamp, message.timestamp != "" else { return }
        let end = isoDate.index(isoDate.endIndex, offsetBy: -5)
        
        isoDate = String(isoDate[..<end])
        let isoFormatter = ISO8601DateFormatter()
        let chatDate = isoFormatter.date(from: isoDate.appending("Z"))
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "MMM d, h:mm a"
        if let finalDate = chatDate {
            let finalDate = newFormatter.string(from: finalDate)
            timestampLabel.text = finalDate
        }
    }
}
