//
//  AvatarCell.swift
//  SmackChat
//
//  Created by Steve Baker on 14/9/17.
//  Copyright © 2017 Steve Baker. All rights reserved.
//

import UIKit

class AvatarCell: UICollectionViewCell {
    
    //outlets
    @IBOutlet weak var avatarImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    func setUpView() {
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
    }
    
}
