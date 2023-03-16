//
//  MainMovieCollectionCell.swift
//  FamousFilmsUsingMVVM
//
//  Created by Haidar Bhatti on 08/03/2023.
//

import UIKit
import SDWebImage

class MainMovieCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblMovieReleaseDate: UILabel!
    @IBOutlet weak var lblVoteRatio: UILabel!
    @IBOutlet weak var viewProgressBar: UIView!
    
    var progressView = CircularProgressView()
    
    public static var identifier: String{
        get{
            return "MainMovieCollectionCell"
        }
    }
    public static func register() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgMovie.round(5)
        viewProgressBar.makeCircleRound()
        addCircularProgressBar()
    }
    
    func setUpCell(cellData: MovieCellData){
        imgMovie.sd_setImage(with: cellData.movieImageURL)
        lblMovieTitle.text = cellData.movieTitle
        let voteAvg = String(format: "%.0f", cellData.voteAverage*10.0)
        lblVoteRatio.text = voteAvg
        lblMovieReleaseDate.text = cellData.movieReleaseDate.toFormatedDate(withFormat: .yDashMDashD)?.getFormattedDate(dateFormat: .ddMMMyyyy)
        setProgress(voteAvg: voteAvg)
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
