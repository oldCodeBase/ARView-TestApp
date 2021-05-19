//
//  UIVIew+Ext.swift
//  ARView-TestApp
//
//  Created by Ibragim Akaev on 19/05/2021.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
