//
//  NewEpisodesTableViewCell.swift
//  Mindvalley
//
//  Created by Admin on 19/07/20.
//  Copyright © 2020 Ketan Parmar. All rights reserved.
//

import UIKit

class NewEpisodesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var newEpisodesCollectionView: UICollectionView!
    
    let str = "KETAN PARMAR SAVARKUNDLA"
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        newEpisodesCollectionView.dataSource = self
        newEpisodesCollectionView.delegate = self
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure() {
    
        self.newEpisodesCollectionView.reloadData()
        self.newEpisodesCollectionView.layoutIfNeeded()
        
    }
    
}

extension NewEpisodesTableViewCell : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewEpisodesCollectionViewCell", for: indexPath) as? NewEpisodesCollectionViewCell else { return UICollectionViewCell() }
        cell.newEpisodeChannelTitleLabel.text = str
        cell.newEpisodeTitleLabel.text = str
        cell.layoutIfNeeded()
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: floor((UIScreen.main.bounds.width - 70)/2), height: 356)
        return size
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}
