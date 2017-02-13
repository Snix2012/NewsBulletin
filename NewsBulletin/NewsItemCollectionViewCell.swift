//
//  NewsItemCollectionViewCell.swift
//  NewsBulletin
//
//  Created by claire.roughan on 12/02/2017.
//  Copyright © 2017 claire.roughan. All rights reserved.
//

import UIKit



class NewsItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 12
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 2
    }
    
}
