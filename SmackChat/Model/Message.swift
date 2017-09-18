//
//  Message.swift
//  SmackChat
//
//  Created by Steve Baker on 18/9/17.
//  Copyright © 2017 Steve Baker. All rights reserved.
//

import Foundation

struct Message {
    
    //get these from api code
    public private(set) var message: String!
    public private(set) var userName: String!
    public private(set) var channelId: String!
    public private(set) var userAvatar: String!
    public private(set) var userAvatarColour: String!
    public private(set) var id: String!
    public private(set) var timestamp: String!
}
