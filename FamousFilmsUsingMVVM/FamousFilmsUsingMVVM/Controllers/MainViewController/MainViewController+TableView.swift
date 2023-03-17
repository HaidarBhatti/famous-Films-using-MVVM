//
//  MainViewController+TableView.swift
//  FamousFilmsUsingMVVM
//
//  Created by Haidar Bhatti on 07/03/2023.
//

import Foundation
import UIKit

extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    
    func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        registerCells()
        registerHeader()
    }
    
    func registerCells(){
        tableView.register(HorizontalCollectionTableViewCell.register(), forCellReuseIdentifier: HorizontalCollectionTableViewCell.identifier)
    }
    
    func registerHeader(){
        tableView.register(MainMovieHeaderView.register(), forHeaderFooterViewReuseIdentifier: MainMovieHeaderView.identifier)
    }
    
    func reloadTableView(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.noOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HorizontalCollectionTableViewCell.identifier, for: indexPath) as? HorizontalCollectionTableViewCell else { return UITableViewCell() }
        
        guard let data = viewModel.cellForRowAt(in: indexPath.section) else {
            return UITableViewCell()
        }
        let viewModel = CollectionViewModel(trendingCollData: data)
        cell.configure(with: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.getCellHeight()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: MainMovieHeaderView.identifier) as! MainMovieHeaderView
        guard let headerData = viewModel.headerForSection(section) else { return nil }
        let headerViewModel = MainMovieHeaderViewModel(headerData: headerData.1, title: headerData.0)
        headerViewModel.delegate = viewModel as! HeaderViewModelDelegate
        headerView.configure(with: headerViewModel)
        return headerView
    }
    
}
