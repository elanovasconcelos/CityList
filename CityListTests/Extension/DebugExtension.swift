//
//  DebugExtension.swift
//  CityListTests
//
//  Created by Elano on 29/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit
@testable import CityList

extension City {
    static func debugArray(count: Int = 10) -> [City] {
        var result = [City]()
        
        for index in 0..<count {
            let doubleIndex = Double(index)
            let city = City(country: "XY",
                            name: "\(index) name",
                            id: index,
                            location: Location(longitude: doubleIndex, latitude: doubleIndex + 1))
            
            result.append(city)
        }
        
        return result
    }
}
