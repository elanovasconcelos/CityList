//
//  UIViewExtension.swift
//  CityList
//
//  Created by Elano on 26/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

extension UIView {

    func anchor(top: NSLayoutYAxisAnchor? = nil,
                leading:NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                trailing: NSLayoutXAxisAnchor? = nil,
                value: CGFloat) {
        
        anchor(top: top,
               leading: leading,
               bottom: bottom,
               trailing: trailing,
               padding: .init(top: value, left: value, bottom: value, right: value))
    }
    
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                leading:NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                trailing: NSLayoutXAxisAnchor? = nil,
                padding: UIEdgeInsets = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
    }
    
    func fullAnchor(view: UIView) {
        anchor(top: view.safeAreaLayoutGuide.topAnchor,
               leading: view.safeAreaLayoutGuide.leadingAnchor,
               bottom: view.safeAreaLayoutGuide.bottomAnchor,
               trailing: view.safeAreaLayoutGuide.trailingAnchor)
    }
    
    func centetAnchor(view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
