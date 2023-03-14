//
//  MainViewController.swift
//  FamousFilmsUsingMVVM
//
//  Created by Haidar Bhatti on 07/03/2023.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        bindViewModel()
        viewModel.getTrendingData()
    }
    
    func configureViews(){
        title = "Home"
        view.backgroundColor = .systemBackground
        setUpTableView()
    }
    
    func bindViewModel(){
        viewModel.isLoadingHomeData.bind { [weak self] isLoading in
            guard let self = self, let isLoading = isLoading else { return }
            DispatchQueue.main.async {
                if isLoading{
                    self.activityIndicator.startAnimating()
                }
                else{
                    self.activityIndicator.stopAnimating()
                    self.reloadTableView()
                }
            }
        }
    }

}
