//
//  UserDataService.swift
//  SmackChat
//
//  Created by Steve Baker on 14/9/17.
//  Copyright © 2017 Steve Baker. All rights reserved.
//

import Foundation

class UserDataService {
    
    static let instance = UserDataService()
    
    public private(set) var id = ""
    public private(set) var avatarColour = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var userName = ""
    
    func setUserData(id: String, avatarColour: String, avatarName: String, email: String, userName: String) {
        self.id = id
        self.avatarColour = avatarColour
        self.avatarName = avatarName
        self.email = email
        self.userName = userName
    }
    
    func setAvatarName(avatarName: String) {
        self.avatarName = avatarName
    }
}
