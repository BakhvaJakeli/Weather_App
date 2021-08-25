//
//  UICollectionViewCell + Extension.swift
//  BookAppTeamWork
//
//  Created by MacBook  on 08.07.21.
//

import UIKit

extension UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle.main)
    }
}
