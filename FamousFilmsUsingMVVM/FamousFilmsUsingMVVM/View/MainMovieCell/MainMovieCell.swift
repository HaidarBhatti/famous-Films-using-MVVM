//
//  MainMovieCell.swift
//  FamousFilmsUsingMVVM
//
//  Created by Haidar Bhatti on 07/03/2023.
//

import UIKit

class MainMovieCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var lblFilmTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.layer.borderColor = UIColor.label.cgColor
        cellView.layer.cornerRadius = 10
        cellView.layer.borderWidth = 1
        movieImg.layer.cornerRadius = 5
    }
    
}
