//
//  MovieCollViewCell.swift
//  FamousFilmsUsingMVVM
//
//  Created by Haidar Bhatti on 02/04/2023.
//

import UIKit
import SDWebImage

class MovieCollViewCell: UICollectionViewCell {

    @IBOutlet weak var cellBGView: UIView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var lblMovieName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellBGView.round()
    }
    
    public static var identifier: String{
        get{
            return "MovieCollViewCell"
        }
    }
    
    public static func register() -> UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    
    func setUpCell(castData: CastForMovie?){
        if let cellData = castData{
            lblMovieName.text = cellData.title ?? cellData.originalTitle ?? ""
            movieImageView.sd_setImage(with: cellData.posterImagePath)
        }
    }    

}
