//
//  UIVIew.swift
//  RelaxApp
//
//  Created by Honglin Yi on 3/7/18.
//  Copyright © 2018 Honglin Yi. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    public class func hyFromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    public class func hyFromNib<T: AnyObject>(_ nibName:String) -> T? {
        let bundle = Bundle(for: T.self)
        let views = bundle.loadNibNamed(nibName, owner: self, options: nil)
        guard let view = views?[0] else { return nil }
        return view as? T
    }
}

public extension UITableViewController {
    public func hyRegisterCellFromNib(identifier:String) {
        let nib = UINib(nibName:identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier:identifier)
    }
}
