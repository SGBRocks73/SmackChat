//
//  MessageService.swift
//  SmackChat
//
//  Created by Steve Baker on 17/9/17.
//  Copyright © 2017 Steve Baker. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    
    static let instance = MessageService()
    var channels = [Channel]()
    var selectedChannel: Channel?
    
    func getAllChannels(completion: @escaping CompletionHandler) {
        Alamofire.request(URL_CHANNEL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: AUTHORISATION).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                if let json = JSON(data: data).array {
                    for item in json {
                        let name = item["name"].stringValue
                        let channelDescirption = item["description"].stringValue
                        let id = item["_id"].stringValue
                        let channel = Channel(channelTitle: name, channelDescription: channelDescirption, channelId: id)
                        self.channels.append(channel)
                    }
                    //notifcation to channelVC to load channels here - reload data
                    NotificationCenter.default.post(name: NOTIF_CHANNELS_RELOAD, object: nil)
                    completion(true)
                }
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }

        }
    }
    
    func clearChanels() {
        channels.removeAll()
    }
    
}
