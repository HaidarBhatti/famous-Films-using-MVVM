//
//  HorizontalCollectionTableViewCell.swift
//  FamousFilmsUsingMVVM
//
//  Created by Haidar Bhatti on 08/03/2023.
//

import UIKit

class HorizontalCollectionTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: CollectionViewModel?
    public static var identifier: String{
        get{
            return "HorizontalCollectionTableViewCell"
        }
    }
    public static func register() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    func configure(with viewModel: CollectionViewModel){
        self.viewModel = viewModel
        self.reloadCollectionView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
    }
    
    func openDetails(movieId: Int){
        guard let movie = viewModel?.retrieveMovie(with: movieId) else { return }
        let viewModel = DetailsMovieViewModel(movie: movie)
        let detailsViewController = DetailsMovieViewController(viewModel: viewModel)
        DispatchQueue.main.async {
            UIApplication.shared.keyWindow!.rootViewController!.topMostViewController().navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }

}

extension HorizontalCollectionTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func setUpCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        registerCells()
    }
    
    func registerCells(){
        collectionView.register(MainMovieCollectionCell.register(), forCellWithReuseIdentifier: MainMovieCollectionCell.identifier)
    }
    
    func reloadCollectionView(){
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.trendingCollData.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let data = viewModel?.trendingCollData else { return UICollectionViewCell() }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainMovieCollectionCell.identifier, for: indexPath) as? MainMovieCollectionCell else { return UICollectionViewCell() }
        cell.setUpCell(cellData: data[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height/1.85, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let data = viewModel?.trendingCollData else { return }
        openDetails(movieId: data[indexPath.item].id)
    }
}


extension UIWindow {
    func topViewController() -> UIViewController? {
        var top = self.rootViewController
        while true {
            if let presented = top?.presentedViewController {
                top = presented
            } else if let nav = top as? UINavigationController {
                top = nav.visibleViewController
            } else if let tab = top as? UITabBarController {
                top = tab.selectedViewController
            } else {
                break
            }
        }
        return top
    }
}

extension UIViewController {
    @objc func topMostViewController() -> UIViewController {
        // Handling Modal views
        if let presentedViewController = self.presentedViewController {
            return presentedViewController.topMostViewController()
        }
        // Handling UIViewController's added as subviews to some other views.
        else {
            for view in self.view.subviews
            {
                // Key property which most of us are unaware of / rarely use.
                if let subViewController = view.next {
                    if subViewController is UIViewController {
                        let viewController = subViewController as! UIViewController
                        return viewController.topMostViewController()
                    }
                }
            }
            return self
        }
    }
}

extension UITabBarController {
    override func topMostViewController() -> UIViewController {
        return self.selectedViewController!.topMostViewController()
    }
}

extension UINavigationController {
    override func topMostViewController() -> UIViewController {
        return self.visibleViewController!.topMostViewController()
    }
}
