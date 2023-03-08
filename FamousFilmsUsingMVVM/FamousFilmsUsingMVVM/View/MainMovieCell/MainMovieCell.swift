//
//  MainMovieCell.swift
//  FamousFilmsUsingMVVM
//
//  Created by Haidar Bhatti on 07/03/2023.
//

import UIKit
import SDWebImage

class MainMovieCell: UITableViewCell {
    
    public static var identifier: String{
        get{
            return "MainMovieCell"
        }
    }
    
    public static func register() -> UINib {
        return UINib(nibName: "MainMovieCell", bundle: nil)
    }

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var lblFilmTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.addBorder(color: .label, width: 1)
        cellView.round()
        cellView.backgroundColor = .lightGray
        movieImg.round(5)
    }
    
    func setUpCell(viewModel: MovieTableCellViewModel){
        movieImg.sd_setImage(with: viewModel.imageURL)
        lblFilmTitle.text = viewModel.title
        lblDate.text = viewModel.date
        lblRating.text = viewModel.ratings
    }
    
}
