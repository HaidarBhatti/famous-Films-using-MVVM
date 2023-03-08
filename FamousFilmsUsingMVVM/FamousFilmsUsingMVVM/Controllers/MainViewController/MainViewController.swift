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
    var cellDataSource: [MovieTableCellViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        bindViewModel()
    }
    
    func configureViews(){
        title = "title here from model"
        view.backgroundColor = .systemBackground
        setUpTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getTrendingData()
    }
    
    func bindViewModel(){
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let self = self, let isLoading = isLoading else { return }
            DispatchQueue.main.async {
                if isLoading{
                    self.activityIndicator.startAnimating()
                }
                else{
                    self.activityIndicator.stopAnimating()
                }
            }
        }
        
        viewModel.cellDataSource.bind { [weak self] movies in
            guard let self = self, let movies = movies else { return }
            self.cellDataSource = movies
            self.reloadTableView()
        }
    }
    
    func openDetails(movieId: Int){
        guard let movie = viewModel.retrieveMovie(withId: movieId) else { return }
        let viewModel = DetailsMovieViewModel(movie: movie)
        let detailsViewController = DetailsMovieViewController(viewModel: viewModel)
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }

}
