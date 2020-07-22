//
//  SeriesCollectionViewCell.swift
//  Mindvalley
//
//  Created by Admin on 22/07/20.
//  Copyright © 2020 Ketan Parmar. All rights reserved.
//

import UIKit

class SeriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var seriesImageView: UIImageView!
    @IBOutlet weak var seriesTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        seriesImageView.layer.cornerRadius = 6.4
        // Initialization code
    }

}
