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
    private var episodes : [EpisodeModel] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    //MARK: - UI and Configuration
    private func setupUI() {
        newEpisodesCollectionView.register(UINib(nibName: Identifiers.newEpisodesCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Identifiers.newEpisodesCollectionViewCell)
        newEpisodesCollectionView.dataSource = self
        newEpisodesCollectionView.delegate = self
    }
    
    func configure(episodes: [EpisodeModel]) {
        self.episodes = episodes
        self.newEpisodesCollectionView.reloadData()
        self.newEpisodesCollectionView.layoutIfNeeded()
    }
}

//MARK: - Collectionview Datasource and Delegates
extension NewEpisodesTableViewCell : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return episodes.count > 6 ? 6 : episodes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.newEpisodesCollectionViewCell, for: indexPath) as? NewEpisodesCollectionViewCell else { return UICollectionViewCell() }
        let episode = episodes[indexPath.item]
        cell.newEpisodeImageView.sd_setImage(with: URL(string: episode.coverAsset.url), completed: nil)
        cell.newEpisodeTitleLabel.text = episode.title
        cell.newEpisodeChannelTitleLabel.text = episode.channel.title.uppercased()
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


