//
//  ChannelVC.swift
//  SmackChat
//
//  Created by Steve Baker on 13/9/17.
//  Copyright © 2017 Steve Baker. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var loginButton: UIButton!
    @IBAction func prepeareForUnwind(segue: UIStoryboardSegue) {}
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
    }

    @IBAction func loginPressed(_ sender: Any) {
        performSegue(withIdentifier: LOGINVC, sender: nil)
    }
    
    
    
}
