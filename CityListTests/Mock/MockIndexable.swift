//
//  MockIndexable.swift
//  CityListTests
//
//  Created by Elano on 25/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit
@testable import CityList

final class MockIndexable: NSObject, Indexable {
    
    let key: String
    
    init(_ key: String) {
        self.key = key
    }
}
