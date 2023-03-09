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
    }
    
    func setUpCell(cellData: MovieCellData){
        imgMovie.sd_setImage(with: cellData.movieImageURL)
        lblMovieTitle.text = cellData.movieTitle
        lblMovieReleaseDate.text = cellData.movieReleaseDate
    }

}
