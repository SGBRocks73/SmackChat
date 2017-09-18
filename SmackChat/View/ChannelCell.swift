//
//  ChannelCell.swift
//  SmackChat
//
//  Created by Steve Baker on 17/9/17.
//  Copyright © 2017 Steve Baker. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

    //outlets
    @IBOutlet weak var channelName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        } else {
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    
    func configCell(channel: Channel) {
        let title = channel.channelTitle ?? ""
        channelName.text = "#\(title)"
        channelName.font = UIFont(name: "AvenirNext-Regular", size: 14)
        
        for unread in MessageService.instance.unreadChannels {
            if unread == channel.channelId {
                channelName.font = UIFont(name: "AvenirNext-Bold", size: 16)
            }
        }
    }
}
