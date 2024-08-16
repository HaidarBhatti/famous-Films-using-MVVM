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
        viewModel.getHomeScreenData()
    }
    
    func configureViews(){
        title = viewModel.title
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
                    if self.viewModel.segementTapped{
                        let indexPath = IndexPath(item: 0, section: self.viewModel.sectionOfCollectionView)
                        self.tableView.reloadRows(at: [indexPath], with: .fade)
                        self.viewModel.isLoadingHomeData.value = nil
//                        self.viewModel.handleTheTapOnSegment()
                        return
                    }
                    else {
                        self.reloadTableView()
                        self.viewModel.isLoadingHomeData.value = nil
                    }
                    
                }
            }
        }
    }
}
