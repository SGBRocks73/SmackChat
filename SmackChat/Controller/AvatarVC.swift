//
//  AvatarVC.swift
//  SmackChat
//
//  Created by Steve Baker on 14/9/17.
//  Copyright © 2017 Steve Baker. All rights reserved.
//

import UIKit

class AvatarVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    //outlets
    @IBOutlet weak var avatarCollection: UICollectionView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    //variables
    var avatarType = AvatarType.dark
    
    override func viewDidLoad() {
        super.viewDidLoad()

        avatarCollection.delegate = self
        avatarCollection.dataSource = self

    }
    
    //collection view functions
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = avatarCollection.dequeueReusableCell(withReuseIdentifier: "AvatarCell", for: indexPath) as? AvatarCell {
            cell.configCell(index: indexPath.item, type: avatarType)
            return cell
        }
        return AvatarCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var numOfColumbs: CGFloat = 3
        //iPhone SE
        if UIScreen.main.bounds.width > 320 {
            numOfColumbs = 4
        }
        let spaceBetweenCells: CGFloat = 10
        let padding: CGFloat = 40
        let cellWidth = ((avatarCollection.bounds.width - padding) - (numOfColumbs - 1) * spaceBetweenCells) / numOfColumbs
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if avatarType == .dark {
            UserDataService.instance.setAvatarName(avatarName: "dark\(indexPath.item)")
        } else {
            UserDataService.instance.setAvatarName(avatarName: "light\(indexPath.item)")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func segmentValueChanged(_ sender: Any) {
        if segmentControl.selectedSegmentIndex == 0 {
            avatarType = .dark
        } else {
            avatarType = .light
        }
        avatarCollection.reloadData()
    }
    
}
