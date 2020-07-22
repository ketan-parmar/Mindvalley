//
//  CourseCollectionViewCell.swift
//  Mindvalley
//
//  Created by Admin on 22/07/20.
//  Copyright © 2020 Ketan Parmar. All rights reserved.
//
import UIKit

class CourseCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlets and Variables
    @IBOutlet weak var courseImageView: UIImageView!
    @IBOutlet weak var courseTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        courseImageView.layer.cornerRadius = 8.0
    }
}
