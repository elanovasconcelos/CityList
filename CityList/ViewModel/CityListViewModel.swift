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
    private let trie: ArrayIndexTrie
    
    weak var delegate: CityListViewModelDelegate?
    var filter: String = "" {
        didSet {
            if oldValue != filter {
                filterChanged()
            }
        }
    }
    
    init(file: GetCityFileAsync = CityFile(),
         delegate: CityListViewModelDelegate? = nil,
         trie: ArrayIndexTrie = ArrayIndexTrie()) {
        
        self.delegate = delegate
        self.trie = trie
        
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
                self.setupTrie()
                //self.models.value = self.allModels
            }
        }
    }
    
    private func setupTrie() {
        trie.insert(sortedArray: allModels) { [weak self] in
            guard let self = self else { return }

            self.updateModelValue(with: self.allModels)
        }
    }
    
    private func filterChanged() {
        
        if filter.isEmpty {
            self.updateModelValue(with: self.allModels)
            return
        }
        
        let indexes = trie.indexes(for: filter)

        if indexes.start != ArrayIndexTrie.IndexNotFound {
            updateModelValue(with: Array(self.allModels[indexes.start ... indexes.end]))
        }else {
            updateModelValue(with: [])
        }
    }
    
    private func updateModelValue(with value: [CityCellViewModel]) {
        self.models.value = value
    }
}
