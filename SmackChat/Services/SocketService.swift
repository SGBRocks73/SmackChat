//
//  SocketService.swift
//  SmackChat
//
//  Created by Steve Baker on 18/9/17.
//  Copyright © 2017 Steve Baker. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {

    static let instance = SocketService()
    
    //required as is a NSObject
    override init() {
        super.init()
    }
    var socket: SocketIOClient = SocketIOClient(socketURL: URL(string: BASE_URL)!)
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    //name is from api code
    func addChannel(name: String, description: String, completion: @escaping CompletionHandler) {
        socket.emit("newChannel", name, description)
        completion(true)
    }
    
    //name is from api code + array of type any data return from api code, ack is acknoledgement
    func obeserveChannel(completion: @escaping CompletionHandler) {
        socket.on("channelCreated") { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String else { return }
            guard let channelDescription = dataArray[1] as? String else { return }
            guard let channelId = dataArray[2] as? String else { return }
            
            let newChannel = Channel(channelTitle: channelName, channelDescription: channelDescription, channelId: channelId)
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }
    
    func sendMessage(messageBody: String, userId: String, channelId: String, completion: @escaping CompletionHandler) {
        let userInst = UserDataService.instance
        socket.emit("newMessage", messageBody, userId, channelId, userInst.userName, userInst.avatarName, userInst.avatarColour)
        completion(true)
    }
    
    func getMessage(completion: @escaping (_ newMessage : Message) -> ()) {
        socket.on("messageCreated") { (dataArray, ack) in
            guard let messageBody = dataArray[0] as? String else { return }
            guard let channelId = dataArray[2] as? String else { return }
            guard let userName = dataArray[3] as? String else { return }
            guard let userAvatar = dataArray[4] as? String else { return }
            guard let userAvatarColour = dataArray[5] as? String else { return }
            guard let messageId = dataArray[6] as? String else { return }
            guard let timestamp = dataArray[7] as? String else { return }
            
            let message = Message(message: messageBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColour: userAvatarColour, id: messageId, timestamp: timestamp)
            completion(message)
        }
    }
    
    func getTyingUsers(_ completion: @escaping (_ typingUsers: [String : String]) -> ()) {
        socket.on("userTypingUpdate") { (dataArray, ack) in
            guard let tryingUsers = dataArray[0] as? [String : String] else { return }
            completion(tryingUsers)
        }
    }
    
}
