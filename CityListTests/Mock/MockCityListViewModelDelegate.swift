//
//  MockCityListViewModelDelegate.swift
//  CityListTests
//
//  Created by Elano on 01/03/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit
@testable import CityList

final class MockCityListViewModelDelegate: NSObject, CityListViewModelDelegate {

    private(set) var callCount: Int = 0
    private(set) var error: FileError?
    private var completionHandler: (MockCityListViewModelDelegate) -> Void
    
    init(completionHandler: @escaping (MockCityListViewModelDelegate) -> Void) {
        self.completionHandler = completionHandler
    }
    
    func cityListViewModel(_ model: CityListViewModel, didReceive error: FileError) {
        self.error = error
        callCount += 1
        
        completionHandler(self)
    }
}
