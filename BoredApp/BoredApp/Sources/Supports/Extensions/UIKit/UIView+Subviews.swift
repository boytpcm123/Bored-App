//
//  UIView+Subviews.swift
//

import UIKit

public protocol ReusableView: AnyObject { }

extension ReusableView where Self: UIView {
    static var dequeueIdentifier: String {
        String(describing: self)
    }
}

protocol NibIdentifiable {
    static var nibIdentifier: String { get }
}

extension NibIdentifiable {
    static var nib: UINib {
        UINib(nibName: nibIdentifier, bundle: nil)
    }
}

extension UIView: NibIdentifiable {
    static var nibIdentifier: String {
        String(describing: self)
    }
}

extension UIViewController: NibIdentifiable {
    static var nibIdentifier: String {
        String(describing: self)
    }
}

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach(addSubview)
    }
}
