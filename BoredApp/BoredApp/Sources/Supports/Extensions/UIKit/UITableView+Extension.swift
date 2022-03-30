//
//  UITableView+Extension.swift
//  hh-poker
//
//  Created by Instajs on 2/1/21.
//

import UIKit

extension UITableView {
    
    func registerReusedCell<T: UITableViewCell>(cellNib: T.Type, bundle: Bundle? = nil) {
        let nib = UINib(nibName: cellNib.dequeueIdentifier, bundle: bundle)
        self.register(nib, forCellReuseIdentifier: cellNib.dequeueIdentifier)
    }
    
    func dequeueReusable<T: UITableViewCell>(cellNib: T.Type, indexPath: IndexPath) -> T? {
        return self.dequeueReusableCell(withIdentifier: cellNib.dequeueIdentifier, for: indexPath) as? T
    }
    
    func dequeueReusable<T: UITableViewCell>(cellNib: T.Type) -> T? {
        return self.dequeueReusableCell(withIdentifier: cellNib.dequeueIdentifier) as? T
    }
    
}

extension UITableViewCell {
    
    static var dequeueIdentifier: String {
        String(describing: self)
    }
    
}
