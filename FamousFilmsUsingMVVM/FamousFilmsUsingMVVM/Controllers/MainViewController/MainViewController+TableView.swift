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
    }
    
    func registerCells(){
        tableView.register(MainMovieCell.register(), forCellReuseIdentifier: MainMovieCell.identifier)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainMovieCell.identifier, for: indexPath) as? MainMovieCell else { return UITableViewCell() }
        let cellViewModel = cellDataSource[indexPath.row]
        cell.setUpCell(viewModel: cellViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieId = cellDataSource[indexPath.row].id
        self.openDetails(movieId: movieId)
    }
    
}
