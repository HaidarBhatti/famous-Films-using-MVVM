//
//  DetailsMovieViewController.swift
//  FamousFilmsUsingMVVM
//
//  Created by Haidar Bhatti on 08/03/2023.
//

import UIKit
import CoreImage

class DetailsMovieViewController: UIViewController {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblMovieDescription: UILabel!
    @IBOutlet weak var lblTagLine: UILabel!
    @IBOutlet weak var lblDateReleased: UILabel!
    @IBOutlet weak var lblGenres: UILabel!
    @IBOutlet weak var lblMovieTime: UILabel!
    @IBOutlet weak var lblVoteRatio: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var viewProgressBar: UIView!
    
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblOriginalLanguage: UILabel!
    @IBOutlet weak var lblBudget: UILabel!
    @IBOutlet weak var lblRevenue: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var progressView = CircularProgressView()
    var viewModel: DetailsMovieViewModel
    
    init(viewModel: DetailsMovieViewModel){
        self.viewModel = viewModel
        super.init(nibName: "DetailsMovieViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViews()
        bindViewModel()
        viewModel.getMovieDetails()
    }
    
    func configViews(){
        title = viewModel.detailsScreenTitle
        moviePosterImageView.round(10)
        addCircularProgressBar()
        viewProgressBar.makeCircleRound()
        setUpCollectionView()
    }
    
    func populateViews(){
        if let movieDetails = viewModel.movieDetails{
            movieImageView.sd_setImage(with: movieDetails.backdropURL)
            activityIndicator.stopAnimating()
            moviePosterImageView.sd_setImage(with: movieDetails.posterURL)
            lblTagLine.text = movieDetails.tagline
            lblMovieTitle.text = movieDetails.title
            lblMovieDescription.text = movieDetails.overview
            lblDateReleased.text = movieDetails.releaseDate!.toFormatedDate(withFormat: .yDashMDashD)?.getFormattedDate(dateFormat: .dslashmslashy)
            lblMovieTime.text = self.viewModel.getTime(runtime: movieDetails.runtime)
            lblGenres.text = self.viewModel.getGenres(genres: movieDetails.genres!)
            let voteAvg = String(format: "%.0f", movieDetails.voteAverage!*10.0)
            lblVoteRatio.text = voteAvg
            setProgress(voteAvg: voteAvg)
            viewProgressBar.backgroundColor = .black
            
            lblStatus.text = movieDetails.status
            lblOriginalLanguage.text = viewModel.getLanguage(name: movieDetails.originalLanguage!)
            
            let budget = movieDetails.budget!
            let revenue = movieDetails.revenue!
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let formattedBudget = numberFormatter.string(from: NSNumber(value: budget))
            let formattedRevenue = numberFormatter.string(from: NSNumber(value: revenue))

            lblBudget.text = "$\(formattedBudget!)"
            lblRevenue.text = "$\(formattedRevenue!)"
            
            reloadCollectionView()
        }
    }
    
    func bindViewModel(){
        viewModel.isLoadingMovieDetails.bind { [weak self] isLoading in
            guard let isLoading = isLoading, let self = self else { return }
            if isLoading{
                self.activityIndicator.startAnimating()
            }
            else{
                self.populateViews()
            }
        }
    }
    
    func makeBlurImage(image: UIImage){
        let inputImage = CIImage(cgImage: image.cgImage!)
        let filter = CIFilter(name: "CIGaussianBlur")
        filter?.setValue(inputImage, forKey: "inputImage")
        filter?.setValue(2.5, forKey: "inputRadius")
        let blurred = filter?.outputImage
        
        var newImageSize: CGRect = (blurred?.extent)!
        newImageSize.origin.x += (newImageSize.size.width - (image.size.width)) / 2
        newImageSize.origin.y += (newImageSize.size.height - (image.size.height)) / 2
        newImageSize.size = (self.movieImageView.image?.size)!
        
        let resultImage: CIImage = filter?.value(forKey: "outputImage") as! CIImage
        let context: CIContext = CIContext.init(options: nil)
        let cgimg: CGImage = context.createCGImage(resultImage, from: newImageSize)!
        let blurredImage: UIImage = UIImage.init(cgImage: cgimg)
        self.movieImageView.image = blurredImage
    }
    
    func addCircularProgressBar(){
        progressView = CircularProgressView(frame: CGRect(x: viewProgressBar.bounds.minX+2.5,
                                                              y: viewProgressBar.bounds.minY+2.5,
                                                              width: viewProgressBar.bounds.width-10,
                                                              height: viewProgressBar.bounds.height-10), lineWidth: 3.5, rounded: false)
        viewProgressBar.addSubview(progressView)
    }
    
    func setProgress(voteAvg: String){
        progressView.progress = Float(String(format: "%.1f", Float(voteAvg)!/100.0)) ?? 0.0
        if let intPorgress = Int(voteAvg){
            if intPorgress >= 71 && intPorgress <= 100{
                progressView.progressColor = .green
                progressView.trackColor = .green.withAlphaComponent(0.1)
            }
            else if intPorgress > 0 && intPorgress < 40{
                progressView.progressColor = .red
                progressView.trackColor = .red.withAlphaComponent(0.1)
            }
            else{
                progressView.progressColor = .yellow
                progressView.trackColor = .yellow.withAlphaComponent(0.1)
            }
        }
    }

}

extension DetailsMovieViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func setUpCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        registerCells()
    }
    
    func registerCells(){
        collectionView.register(CrewAndCastCollViewCell.register(), forCellWithReuseIdentifier: CrewAndCastCollViewCell.identifier)
    }
    
    func reloadCollectionView(){
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.noOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.noOfItemsInsection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CrewAndCastCollViewCell.identifier, for: indexPath) as! CrewAndCastCollViewCell
        let castData = viewModel.cellFor(ItemAt: indexPath.item)
        cell.setUpCell(castData: castData)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 105, height: 180)
    }
    
}
