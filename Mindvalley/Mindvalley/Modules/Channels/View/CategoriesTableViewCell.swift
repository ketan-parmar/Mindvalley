//
//  CategoriesTableViewCell.swift
//  Mindvalley
//
//  Created by Admin on 21/07/20.
//  Copyright © 2020 Ketan Parmar. All rights reserved.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {

    
    @IBOutlet weak var categoryLabel1: UILabel!
    @IBOutlet weak var categoryLabel2: UILabel!
    @IBOutlet weak var categoryView1: UIView!
    @IBOutlet weak var categoryView2: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryView1.layer.cornerRadius = 30
        categoryView2.layer.cornerRadius = 30
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(category: [CategoriesModel]) {

        categoryLabel1.text = category[0].name
        if category.count > 1 {
            categoryLabel2.text = category[1].name
            categoryView2.backgroundColor = UIColor(rgb: 0x95989D, a: 0.2)
        } else {
            categoryLabel2.text = ""
            categoryView2.backgroundColor = .clear
        }
              
    }
}



//******


//class NewEpisodesTableViewCell: UITableViewCell {
//    
//    @IBOutlet weak var newEpisodesCollectionView: UICollectionView!
//    var medias : [MediaModel] = []
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//      
//        newEpisodesCollectionView.dataSource = self
//        newEpisodesCollectionView.delegate = self
//        
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
//    
//    func configure(medias: [MediaModel]) {
//
//        self.medias = medias
//        self.newEpisodesCollectionView.reloadData()
//        self.newEpisodesCollectionView.layoutIfNeeded()
//        
//    }
//    
//}
//
//extension NewEpisodesTableViewCell : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return medias.count > 6 ? 6 : medias.count
//    }
//    
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewEpisodesCollectionViewCell", for: indexPath) as? NewEpisodesCollectionViewCell else { return UICollectionViewCell() }
//        let media = medias[indexPath.item]
//        
//        cell.newEpisodeImageView.sd_setImage(with: URL(string: media.coverAsset.url), completed: nil)
//        cell.newEpisodeTitleLabel.text = media.title
//        cell.newEpisodeChannelTitleLabel.text = media.channel.title.uppercased()
//      //  cell.layoutIfNeeded()
//        return cell
//    }
//    
//    
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        let size = CGSize(width: floor((UIScreen.main.bounds.width - 70)/2), height: 356)
//        return size
//       
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
//    }
//}
//



///************

//class NewEpisodesCollectionViewCell: UICollectionViewCell {
//
//    
//    @IBOutlet weak var newEpisodeImageView: UIImageView!
//    @IBOutlet weak var newEpisodeTitleLabel: UILabel!
//    @IBOutlet weak var newEpisodeChannelTitleLabel: UILabel!
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        newEpisodeImageView.layer.cornerRadius = 8.0
//        // Initialization code
//    }
//
//}

