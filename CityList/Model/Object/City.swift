//
//  City.swift
//  CityList
//
//  Created by Elano on 25/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

final class City: NSObject, Decodable {
    let country: String
    let name: String
    let id: Int
    let location: Location
    
    init(country: String, name: String, id: Int, location: Location) {
        self.country = country
        self.name = name
        self.id = id
        self.location = location
    }
    
    private enum CodingKeys: String, CodingKey {
        case country
        case name
        case id = "_id"
        case location = "coord"
    }
}
