//
//  CourseTableViewCell.swift
//  Mindvalley
//
//  Created by Admin on 21/07/20.
//  Copyright © 2020 Ketan Parmar. All rights reserved.
//

import UIKit

class CourseTableViewCell: UITableViewCell {
    
    //MARK: - Outlets and Variables
    @IBOutlet weak var courseIconImageView: UIImageView!
    @IBOutlet weak var courseTitle: UILabel!
    @IBOutlet weak var courseEpisodesCount: UILabel!
    @IBOutlet weak var courseCollectionView: UICollectionView!
    
    ///
    private var channelLatestMedia : [ChannelLatestMedia] = []
    var collectionViewOffset: CGFloat {
        get {
            return courseCollectionView.contentOffset.x
        }
        set {
            courseCollectionView.contentOffset.x = newValue
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    //MARK: - UI and Configuration
    private func setupUI() {
        courseCollectionView.register(UINib(nibName: Identifiers.courseCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Identifiers.courseCollectionViewCell)
        courseCollectionView.dataSource = self
        courseCollectionView.delegate = self
        courseIconImageView.layer.cornerRadius = 25
    }
    
    func configure(course: [ChannelLatestMedia], offset: CGFloat) {
        
        self.channelLatestMedia = course
        self.courseCollectionView.reloadData()
        self.courseCollectionView.layoutIfNeeded()
        self.collectionViewOffset = offset
    }
    
}

//MARK: - Collectionview Datasource and Delegates
extension CourseTableViewCell : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.channelLatestMedia.count > 6 ? 6 : self.channelLatestMedia.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.courseCollectionViewCell, for: indexPath) as? CourseCollectionViewCell else { return UICollectionViewCell() }
        let media = self.channelLatestMedia[indexPath.item]
        
        if let url = media.coverAsset.url {
            cell.courseImageView.sd_setImage(with: URL(string: url), completed: nil)
        } else {
            cell.courseImageView.image = nil
        }
        
        cell.courseTitleLabel.text = media.title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: floor((UIScreen.main.bounds.width - 70)/2), height: 338)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}
