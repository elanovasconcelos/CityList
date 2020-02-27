//
//  CityTableViewCell.swift
//  CityList
//
//  Created by Elano on 26/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

final class CityTableViewCell: BaseTableViewCell<CityCellViewModel> {

    override class var identifier: String { return "CityTableViewCell" }
    
    @IBOutlet var cityTitleLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    
    override var item: CityCellViewModel? {
        didSet {
            setup()
        }
    }

    private func setup() {
        cityTitleLabel.text = item?.title
        locationLabel.text = item?.subtitle
    }
}
