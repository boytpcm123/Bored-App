//
//  UICollectionView+Extension.swift
//  BoredApp
//
//  Created by hungdat1234 on 4/27/22.
//

import UIKit

extension UICollectionView {

    func registerCell<T: UICollectionViewCell>(type: T.Type) {
        register(type.nib, forCellWithReuseIdentifier: String(describing: T.self))
    }

    func dequeueReusableCell<T: UICollectionViewCell>(type: T.Type, forIndexPath indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: String(describing: T.self),
                                                  for: indexPath) as? T else {
            fatalError("Couldn't find nib file for \(String(describing: T.self))")
        }
        return cell
    }
}
