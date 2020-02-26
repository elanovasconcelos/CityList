//
//  GetCityFileAsync.swift
//  CityList
//
//  Created by Elano on 26/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

protocol GetCityFileAsync {
    func get(completionHandler: @escaping (Result<[City], FileError>) -> Void)
}
