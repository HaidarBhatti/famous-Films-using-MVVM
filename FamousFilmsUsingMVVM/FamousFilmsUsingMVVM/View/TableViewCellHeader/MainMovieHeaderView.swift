//
//  MainMovieHeaderView.swift
//  FamousFilmsUsingMVVM
//
//  Created by Haidar Bhatti on 15/03/2023.
//

import UIKit

class MainMovieHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var lblHeaderTitle: UILabel!
    @IBOutlet weak var btnDropDown: UIButton!

    var title: String?{
        didSet{
            populateValues()
        }
    }
    
    public static var identifier: String{
        get{
            return "MainMovieHeaderView"
        }
    }
    
    public static func register() -> UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    
    func populateValues(){
        lblHeaderTitle.text = title
    }

}
