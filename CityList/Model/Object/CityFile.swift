//
//  CityFile.swift
//  CityList
//
//  Created by Elano on 26/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

final class CityFile: File<[City]>, GetCityFileAsync {

    init() {
        super.init(name: "cities")
    }
}
