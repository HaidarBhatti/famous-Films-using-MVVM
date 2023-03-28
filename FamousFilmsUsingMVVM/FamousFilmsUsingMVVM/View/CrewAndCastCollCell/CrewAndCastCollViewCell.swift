//
//  CrewAndCastCollViewCell.swift
//  FamousFilmsUsingMVVM
//
//  Created by Haidar Bhatti on 28/03/2023.
//

import UIKit
import SDWebImage

struct CastModel{
    var castImage: URL?
    var castOriginalName: String
    var castMovieName: String
    var gender: Int
}

class CrewAndCastCollViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellBGView: UIView!
    @IBOutlet weak var castPortrait: UIImageView!
    @IBOutlet weak var lblCastOriginalName: UILabel!
    @IBOutlet weak var lblCastMovieName: UILabel!
    
    public static var identifier: String{
        get{
            return "CrewAndCastCollViewCell"
        }
    }
    
    public static func register() -> UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellBGView.round()
    }
    
    func setUpCell(castData: CastModel?){
        if let castData = castData{
            if let url = castData.castImage{
                castPortrait.sd_setImage(with: url)
            }
            else{
                if castData.gender == 0{
                    castPortrait.image = UIImage(named: femaleAvatar)
                }
                else if castData.gender == 2{
                    castPortrait.image = UIImage(named: maleAvatar)
                }
            }
            lblCastOriginalName.text = castData.castOriginalName
            lblCastMovieName.text = castData.castMovieName
        }
    }

}
