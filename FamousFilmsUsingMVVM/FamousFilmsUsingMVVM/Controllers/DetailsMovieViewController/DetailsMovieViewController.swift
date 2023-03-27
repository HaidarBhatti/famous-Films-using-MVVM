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
        addCircularProgressBar()
        viewProgressBar.makeCircleRound()
    }
    
    func populateViews(){
        if let movieDetails = viewModel.movieDetails{
            movieImageView.sd_setImage(with: movieDetails.backdropURL) { [weak self] image, error, cache, url in
                guard let self = self, let image = image else { return }
                
                self.makeBlurImage(image: image)
                self.activityIndicator.stopAnimating()
                self.moviePosterImageView.sd_setImage(with: movieDetails.posterURL)
                
                self.lblTagLine.text = movieDetails.tagline
                self.lblMovieTitle.text = movieDetails.title
                self.lblMovieDescription.text = movieDetails.overview
                self.lblDateReleased.text = movieDetails.releaseDate!.toFormatedDate(withFormat: .yDashMDashD)?.getFormattedDate(dateFormat: .dslashmslashy)
                self.lblMovieTime.text = self.viewModel.getTime(runtime: movieDetails.runtime)
                self.lblGenres.text = self.viewModel.getGenres(genres: movieDetails.genres!)
                
                let voteAvg = String(format: "%.0f", movieDetails.voteAverage!*10.0)
                self.lblVoteRatio.text = voteAvg
                self.setProgress(voteAvg: voteAvg)
                self.viewProgressBar.backgroundColor = .black
            }
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
            switch intPorgress{
            case 0:
                progressView.progressColor = .red
                progressView.trackColor = .red.withAlphaComponent(0.1)
            case 71...100:
                progressView.progressColor = .green
                progressView.trackColor = .green.withAlphaComponent(0.1)
            case 51...70:
                progressView.progressColor = .yellow
                progressView.trackColor = .yellow.withAlphaComponent(0.1)
            default:
                progressView.progressColor = .white
                progressView.trackColor = .white.withAlphaComponent(0.1)
            }
        }
    }

}
