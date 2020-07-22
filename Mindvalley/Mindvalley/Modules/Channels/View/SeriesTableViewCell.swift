//
//  SeriesTableViewCell.swift
//  Mindvalley
//
//  Created by Admin on 22/07/20.
//  Copyright © 2020 Ketan Parmar. All rights reserved.
//

import UIKit

class SeriesTableViewCell: UITableViewCell {
    
    //MARK: - Outlets and Variables
    @IBOutlet weak var seriesIconImageView: UIImageView!
    @IBOutlet weak var seriesTitle: UILabel!
    @IBOutlet weak var seriesEpisodesCount: UILabel!
    @IBOutlet weak var seriesCollectionView: DynamicHeightCollectionView!
    
    ///
    var channelSeries : [ChannelSeries] = []
    var collectionViewOffset: CGFloat {
        get {
            return seriesCollectionView.contentOffset.x
        }
        set {
            seriesCollectionView.contentOffset.x = newValue
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    //MARK: - UI and Configuration
    func setupUI() {
        seriesCollectionView.register(UINib(nibName: "SeriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SeriesCollectionViewCell")
        seriesCollectionView.dataSource = self
        seriesCollectionView.delegate = self
        seriesIconImageView.layer.cornerRadius = 25
    }
    
    func configure(series: [ChannelSeries], offset: CGFloat) {
        self.channelSeries = series
        self.seriesCollectionView.reloadData()
        self.seriesCollectionView.layoutIfNeeded()
        self.collectionViewOffset = offset
    }
    
}

//MARK: - Collectionview Datasource and Delegates
extension SeriesTableViewCell : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.channelSeries.count > 6 ? 6 : self.channelSeries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeriesCollectionViewCell", for: indexPath) as? SeriesCollectionViewCell else { return UICollectionViewCell() }
        let series = self.channelSeries[indexPath.item]
        
        if let url = series.coverAsset.url {
            cell.seriesImageView.sd_setImage(with: URL(string: url), completed: nil)
        } else {
            cell.seriesImageView.image = nil
        }
        
        cell.seriesTitleLabel.text = series.title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: floor(UIScreen.main.bounds.width - 60), height: 242)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}
