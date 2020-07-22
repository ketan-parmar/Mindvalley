//
//  NewEpisodesCollectionViewCell.swift
//  Mindvalley
//
//  Created by Admin on 22/07/20.
//  Copyright © 2020 Ketan Parmar. All rights reserved.
//

import UIKit

class NewEpisodesCollectionViewCell: UICollectionViewCell {


    @IBOutlet weak var newEpisodeImageView: UIImageView!
    @IBOutlet weak var newEpisodeTitleLabel: UILabel!
    @IBOutlet weak var newEpisodeChannelTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        newEpisodeImageView.layer.cornerRadius = 8.0
        // Initialization code
    }

}
