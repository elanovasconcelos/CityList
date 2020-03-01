//
//  CityListViewModelTests.swift
//  CityListTests
//
//  Created by Elano on 29/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import XCTest
@testable import CityList

class CityListViewModelTests: XCTestCase {

    func testModels() {
        let cities = City.debugArray()
        let viewModel = newViewModel(cities: cities)
        let expectation = self.expectation(description: "valueChanged")
        
        viewModel.models.valueChanged = { models in
            
            XCTAssertEqual(models.count, cities.count)
            XCTAssertFalse(models.isEmpty)
            
            if !models.isEmpty && !cities.isEmpty {
                let model = models[0]
                let city = cities[0]
                
                XCTAssertEqual(model.title, city.name + ", " + city.country)
                XCTAssertEqual(model.subtitle, "latitude: 1.0 longitude: 0.0")
                XCTAssertEqual(model.key, "0 name, xy")
                
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 1)
    }

    func testFilter() {
        let viewModel = newViewModel(cities: City.debugArray(count: 21))
        let expectation = self.expectation(description: "valueChanged")
        
        viewModel.filter = "2"
        viewModel.models.valueChanged = { models in
            
            XCTAssertEqual(models.count, 2)
            
            if models.count >= 2 {
   
                XCTAssertEqual(models[0].title, "2 name, XY")
                XCTAssertEqual(models[1].title, "20 name, XY")
                
                expectation.fulfill()
            }
        }

        waitForExpectations(timeout: 1)
    }
    
    func testBigFilter() {
         let viewModel = newViewModel(cities: City.debugArray(count: 99))
         let expectation = self.expectation(description: "valueChanged")
         
         viewModel.filter = "3"
         viewModel.models.valueChanged = { models in
             
             XCTAssertEqual(models.count, 11)
             
             if models.count >= 11 {
    
                 XCTAssertEqual(models[0].title, "3 name, XY")
                 XCTAssertEqual(models[10].title, "39 name, XY")
                 
                 expectation.fulfill()
             }
         }

         waitForExpectations(timeout: 2)
     }
    
    func testEmptyFilter() {
        let viewModel = newViewModel()
        let expectation = self.expectation(description: "valueChanged")
        
        viewModel.filter = "99"
        viewModel.models.valueChanged = { models in
            
            XCTAssertTrue(models.isEmpty)
            
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }
    
    func testError() {
        let expectation = self.expectation(description: "delegate")
        let mock = MockGetCityFileAsync(cities: City.debugArray(), sendError: true)
        let viewModeldelegate = MockCityListViewModelDelegate { (delegate) in
            
            XCTAssertEqual(delegate.callCount, 1)
            XCTAssertEqual(delegate.error, FileError.data)
            
            expectation.fulfill()
        }
        let _ = CityListViewModel(file: mock, delegate: viewModeldelegate)
        
        waitForExpectations(timeout: 1)
    }
    
    //MARK: -
    func newViewModel(cities: [City] = City.debugArray(),
                      delegate: CityListViewModelDelegate? = nil) -> CityListViewModel {
        let mock = MockGetCityFileAsync(cities: cities)
        return CityListViewModel(file: mock, delegate: delegate)
    }
}
