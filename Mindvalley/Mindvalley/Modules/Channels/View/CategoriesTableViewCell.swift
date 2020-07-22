//
//  CategoriesTableViewCell.swift
//  Mindvalley
//
//  Created by Admin on 21/07/20.
//  Copyright © 2020 Ketan Parmar. All rights reserved.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {
    
    //MARK: - Outlets and Variables
    @IBOutlet weak var categoryLabel1: UILabel!
    @IBOutlet weak var categoryLabel2: UILabel!
    @IBOutlet weak var categoryView1: UIView!
    @IBOutlet weak var categoryView2: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    //MARK: - UI and Configuration
    func setupUI() {
        categoryView1.layer.cornerRadius = 30
        categoryView2.layer.cornerRadius = 30
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

