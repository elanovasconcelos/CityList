//
//  BaseViewController.swift
//  CityList
//
//  Created by Elano on 26/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

class BaseViewController<T: BaseTableViewCell<U>, U>: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {

    private lazy var searchController = UISearchController(searchResultsController: nil)
    private let enableSearch: Bool
    private let tableView: UITableView = {
       
        let newTableView = UITableView(frame: .zero)

        newTableView.rowHeight = UITableView.automaticDimension
        newTableView.estimatedRowHeight = 44
        newTableView.tableFooterView = UIView()
        
        return newTableView
    }()
    
    //MARK: -
    var items = [U]() {
        didSet {
            reloadTable()
        }
    }
    
    //MARK: -
    init(enableSearch: Bool = false) {
        self.enableSearch = enableSearch
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()

        setupController()
        setupTableView()
        setupSearch()
    }
    
    //MARK: -
    private func setupController() {
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
    }
    
    private func setupTableView() {

        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(nibNameAndIdentifier: T.identifier)
        tableView.fullAnchor(view: view)
    }

    private func setupSearch() {
        if !enableSearch {
            return
        }
        
        //fix the searchController color for navigationBar.isTranslucent = false
        extendedLayoutIncludesOpaqueBars = true
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Cities"
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    //MARK: -
    func hideTable(_ hide: Bool) {
        tableView.isHidden = hide
    }
    
    func reloadTable() {
        ThreadHelper.main {
            self.tableView.reloadData()
        }
    }
    
    func closeKeyboard() {
        ThreadHelper.main {
            self.tableView.endEditing(false)
        }
    }
    
    func rowSelected(at indexPath: IndexPath) {
        
    }
    
    func searched(for text: String) {
        
    }
    
    //MARK: - UITableViewDataSource, UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! BaseTableViewCell<U>
        
        cell.item = items[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowSelected(at: indexPath)
    }
    
    //MARK: - UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        searched(for: searchBar.text ?? "")
    }
}
