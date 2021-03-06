//
//  ViewController.swift
//  CityList
//
//  Created by Elano on 25/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

final class CityListViewController: BaseViewController<CityTableViewCell, CityCellViewModel> {

    private let viewModel: CityListViewModel
    
    //MARK: -
    init(viewModel: CityListViewModel) {
        self.viewModel = viewModel
        
        super.init(enableSearch: true)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -
    private func setup() {
        title = "Cities"
        
        setupViewModel()
        showActivityIndicator()
    }
    
    private func setupViewModel() {
        viewModel.delegate = self
        viewModel.models.valueChanged = { [weak self] items in
            self?.items = items
            self?.hideActivityIndicator()
        }
    }
    
    //MARK: -
    override func searched(for text: String) {
        viewModel.filter = text
    }
    
    override func rowSelected(at indexPath: IndexPath) {
        let cellModel = viewModel.models.value[indexPath.row]
        let controller = MapViewController(name: cellModel.title, location: cellModel.location)
        navigationController?.pushViewController(controller, animated: true)
        
        closeKeyboard()
    }
}

//MARK: - CityListViewModelDelegate
extension CityListViewController: CityListViewModelDelegate {
    func cityListViewModel(_ model: CityListViewModel, didReceive error: FileError) {
        print("[CityListViewController|didReceive]: \(error)")
    }
}
