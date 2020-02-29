//
//  MockGetCityFileAsync.swift
//  CityListTests
//
//  Created by Elano on 29/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit
@testable import CityList

final class MockGetCityFileAsync: NSObject, GetCityFileAsync {
    
    let cities: [City]
    var sendError = false
    
    init(cities: [City], sendError: Bool = false) {
        self.cities = cities
        self.sendError = sendError
    }
    
    func get(completionHandler: @escaping (Result<[City], FileError>) -> Void) {
        if sendError {
            completionHandler(.failure(.data))
        }else {
            completionHandler(.success(cities))
        }
    }
}
