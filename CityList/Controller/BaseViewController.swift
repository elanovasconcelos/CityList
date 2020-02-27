//
//  BaseViewController.swift
//  CityList
//
//  Created by Elano on 26/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

class BaseViewController<T: BaseTableViewCell<U>, U>: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private let tableView: UITableView = {
       
        let newTableView = UITableView(frame: .zero)

        newTableView.rowHeight = UITableView.automaticDimension
        newTableView.estimatedRowHeight = 44
        
        return newTableView
    }()
    
    //MARK: -
    var items = [U]() {
        didSet {
            reloadTable()
        }
    }
    
    //MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()

        setupController()
        setupTableView()
    }
    
    //MARK: -
    private func setupController() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupTableView() {

        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(nibNameAndIdentifier: T.identifier)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                              leading: view.safeAreaLayoutGuide.leadingAnchor,
                              bottom: view.safeAreaLayoutGuide.bottomAnchor,
                              trailing: view.safeAreaLayoutGuide.trailingAnchor)
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
    
    func rowSelected(at indexPath: IndexPath) {
        
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
}
