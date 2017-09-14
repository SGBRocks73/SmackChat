//
//  AvatarCell.swift
//  SmackChat
//
//  Created by Steve Baker on 14/9/17.
//  Copyright © 2017 Steve Baker. All rights reserved.
//

import UIKit

enum AvatarType {
    case dark
    case light
}

class AvatarCell: UICollectionViewCell {
    
    //outlets
    @IBOutlet weak var avatarImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    func configCell(index: Int, type: AvatarType) {
        if type == AvatarType.dark {
            avatarImage.image = UIImage(named: "dark\(index)")
            self.layer.backgroundColor = UIColor.lightGray.cgColor
        } else {
            avatarImage.image = UIImage(named: "light\(index)")
            self.layer.backgroundColor = UIColor.gray.cgColor
        }
    }
    
    func setUpView() {
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
    }
    
}
