//
//  CityCellViewModel.swift
//  CityList
//
//  Created by Elano on 26/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

final class CityCellViewModel: NSObject, Indexable, Comparable {

    let title: String
    let subtitle: String
    let key: String
    
    init(city: City) {
        title = city.name + ", " + city.country
        subtitle = "latitude: \(city.location.latitude) longitude: \(city.location.longitude)"
        key = title
    }
    
    //MARK: - Comparable
    static func < (lhs: CityCellViewModel, rhs: CityCellViewModel) -> Bool {
        return lhs.key < rhs.key
    }
}
