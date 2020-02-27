//
//  CityListViewModel.swift
//  CityList
//
//  Created by Elano on 26/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

protocol CityListViewModelDelegate: class {
    func cityListViewModel(_ model: CityListViewModel, didReceive error: FileError)
}

final class CityListViewModel: NSObject {

    private lazy var allModels = [CityCellViewModel]()
    private(set) lazy var models = Observable<[CityCellViewModel]>([])
    
    weak var delegate: CityListViewModelDelegate?
    var filter: String = "" { didSet { filterChanged() } }
    
    init(file: GetCityFileAsync = CityFile(), delegate: CityListViewModelDelegate? = nil) {
        self.delegate = delegate
        
        super.init()
        
        updateAllCities(file: file)
    }
    
    private func updateAllCities(file: GetCityFileAsync) {
        file.get { [weak self] (result) in
            
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                self.delegate?.cityListViewModel(self, didReceive: error)
            case .success(let cities):
                self.allModels = cities.map({ CityCellViewModel(city: $0) }).sorted()
                self.models.value = self.allModels
            }
        }
    }
    
    private func filterChanged() {
        
    }
}
