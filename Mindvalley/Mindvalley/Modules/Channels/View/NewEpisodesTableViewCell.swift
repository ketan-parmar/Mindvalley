//
//  NewEpisodesTableViewCell.swift
//  Mindvalley
//
//  Created by Admin on 22/07/20.
//  Copyright © 2020 Ketan Parmar. All rights reserved.
//

import UIKit

class NewEpisodesTableViewCell: UITableViewCell {
    
    //MARK: - Outlets and Variables
    @IBOutlet weak var newEpisodesCollectionView: UICollectionView!
    var medias : [MediaModel] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    //MARK: - UI and Configuration
    func setupUI() {
        newEpisodesCollectionView.register(UINib(nibName: "NewEpisodesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NewEpisodesCollectionViewCell")
        newEpisodesCollectionView.dataSource = self
        newEpisodesCollectionView.delegate = self
    }
    
    func configure(medias: [MediaModel]) {
        self.medias = medias
        self.newEpisodesCollectionView.reloadData()
        self.newEpisodesCollectionView.layoutIfNeeded()
    }
}

//MARK: - Collectionview Datasource and Delegates
extension NewEpisodesTableViewCell : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return medias.count > 6 ? 6 : medias.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewEpisodesCollectionViewCell", for: indexPath) as? NewEpisodesCollectionViewCell else { return UICollectionViewCell() }
        let media = medias[indexPath.item]
        cell.newEpisodeImageView.sd_setImage(with: URL(string: media.coverAsset.url), completed: nil)
        cell.newEpisodeTitleLabel.text = media.title
        cell.newEpisodeChannelTitleLabel.text = media.channel.title.uppercased()
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


