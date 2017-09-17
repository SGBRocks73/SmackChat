//
//  Constants.swift
//  SmackChat
//
//  Created by Steve Baker on 14/9/17.
//  Copyright © 2017 Steve Baker. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()

//segues
let LOGINVC = "LoginVC"
let ACCOUNTVC = "AccountVC"
let UNWIND = "UnwindToChannel"
let AVATARVC = "AvatarVC"

//user defaults
let LOGGED_IN_KEY = "token"
let TOKEN_KEY = "loggedin"
let USER_EMAIL = "userEmail"

//api
let BASE_URL = "https://sgbimagery-smackchat.herokuapp.com/v1"
let URL_REGISTER = "\(BASE_URL)/account/register"
let URL_LOGIN = "\(BASE_URL)/account/login"
let URL_USER_ADD = "\(BASE_URL)/user/add"
let URL_USER_EMAIL = "\(BASE_URL)/user/byEmail/"
let URL_CHANNEL = "\(BASE_URL)/channel"

//headers
let HEADER = [
    "Content-Type" : "application/json; charset=utf-8"
]
let HEADER_BEARER = [
    "Authorization" : "Bearer \(AuthService.instance.authToken)",
    "Content-Type" : "application/json; charset=utf-8"
]
let AUTHORISATION = [
    "Authorization" : "Bearer \(AuthService.instance.authToken)"
]

//colours
let SCPURPLE = #colorLiteral(red: 0.3266413212, green: 0.4215201139, blue: 0.7752227187, alpha: 0.5)

//Notification constants
let NOTIF_USER_DATA_DID_CHANGE = Notification.Name("notifUserDataChanged")
