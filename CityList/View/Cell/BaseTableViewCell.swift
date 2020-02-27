//
//  BaseTableViewCell.swift
//  CityList
//
//  Created by Elano on 26/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

class BaseTableViewCell<U>: UITableViewCell {

    class var identifier: String {
        fatalError("not implemented")
    }
    
    var item: U?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

//MARK: -
class Observable<T> {
    var value: T {
        didSet {
            ThreadHelper.main {
                self.valueChanged?(self.value)
            }
        }
    }
    var valueChanged: ((T) -> Void)?
    
    init(_ value: T) {
        self.value = value
    }
}
