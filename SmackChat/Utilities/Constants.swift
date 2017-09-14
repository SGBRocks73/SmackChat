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

//user defaults
let LOGGED_IN_KEY = "token"
let TOKEN_KEY = "loggedin"
let USER_EMAIL = "userEmail"


//api
let BASE_URL = "https://sgbimagery-smackchat.herokuapp.com/v1"
let REGISTER_URL = "\(BASE_URL)/account/register"
