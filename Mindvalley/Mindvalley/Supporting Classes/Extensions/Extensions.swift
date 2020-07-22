//
//  Extensions.swift
//  Mindvalley
//
//  Created by Admin on 19/07/20.
//  Copyright © 2020 Ketan Parmar. All rights reserved.
//

import Foundation
import UIKit

// MARK: - UINavigationBar
extension UINavigationBar {
    func setNavigationBarAppearance() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(rgb: 0xC1C1C1, a: 1.0), .font: UIFont(name: "Roboto-Black", size: 15)!]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(rgb: 0xC1C1C1, a: 1.0), .font: UIFont(name: "Roboto-Bold", size: 30)!]
        navBarAppearance.backgroundColor = UIColor(rgb: 0x23272F, a: 1.0)
        self.standardAppearance = navBarAppearance
    }
}

// MARK: - UIColor
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: a
        )
    }
    
    convenience init(rgb: Int, a: CGFloat = 1.0) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF,
            a: a
        )
    }
}

// MARK: - Array
extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
