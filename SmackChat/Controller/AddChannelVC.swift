//
//  AddChannelVC.swift
//  SmackChat
//
//  Created by Steve Baker on 17/9/17.
//  Copyright © 2017 Steve Baker. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

    //outlets
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var descriptionText: UITextField!
    @IBOutlet weak var backgroundView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
    }
    
    func setUpView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.tapScreen(_:)))
        backgroundView.addGestureRecognizer(tap)
        backgroundView.addGestureRecognizer(tap)
        let attibutes = [NSAttributedStringKey.foregroundColor : SCPURPLE]
        nameText.attributedPlaceholder = NSAttributedString(string: "name", attributes: attibutes)
        descriptionText.attributedPlaceholder = NSAttributedString(string: "description", attributes: attibutes)
    }
    
    @objc func tapScreen(_ recogniser: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func createChannelPressed(_ sender: Any) {
        
    }
    
}
