//
//  Location.swift
//  CityList
//
//  Created by Elano on 25/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

final class Location: NSObject, Decodable {
    let longitude: Double
    let latitude: Double
    
    init(longitude: Double = 0, latitude: Double = 0) {
        self.longitude = longitude
        self.latitude = latitude
    }
    
    private enum CodingKeys: String, CodingKey {
        case longitude = "lon"
        case latitude = "lat"
    }
}
