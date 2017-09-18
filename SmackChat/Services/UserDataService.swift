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
    
    func getImageColour(elements: String) -> UIColor {
        let scanner = Scanner(string: elements)
        let skipChar = CharacterSet(charactersIn: "[],  ")
        let comma = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skipChar
        var red, green, blue, alpha: NSString?
        scanner.scanUpToCharacters(from: comma, into: &red)
        scanner.scanUpToCharacters(from: comma, into: &green)
        scanner.scanUpToCharacters(from: comma, into: &blue)
        scanner.scanUpToCharacters(from: comma, into: &alpha)
        
        let defaultColour = UIColor.lightGray
        guard let redUnwrapped = red else { return defaultColour }
        guard let greenUnwrapped = green else { return defaultColour }
        guard let blueUnwrapped = blue else { return defaultColour }
        guard let alphaUnwrapped = alpha else { return defaultColour }
        
        let redFloat = CGFloat(redUnwrapped.doubleValue)
        let greenFloat = CGFloat(greenUnwrapped.doubleValue)
        let blueFloat = CGFloat(blueUnwrapped.doubleValue)
        let alphaFloat = CGFloat(alphaUnwrapped.doubleValue)
        
        let newColor = UIColor(red: redFloat, green: greenFloat, blue: blueFloat, alpha: alphaFloat)
        return newColor
    }
    
    func logOutUser() {
        id = ""
        email = ""
        userName = ""
        avatarColour = ""
        avatarName = ""
        AuthService.instance.loggedIN = false
        AuthService.instance.authToken = ""
        AuthService.instance.userEmail = ""
        MessageService.instance.clearChanels()
        MessageService.instance.clearMessages()
    }
}
