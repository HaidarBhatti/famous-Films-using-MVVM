//
//  DetailsPersonViewController.swift
//  FamousFilmsUsingMVVM
//
//  Created by Haidar Bhatti on 01/04/2023.
//

import UIKit
import ExpandableLabel
import SDWebImage

class DetailsPersonViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var castImageView: UIImageView!
    @IBOutlet weak var lblCastName: UILabel!
    @IBOutlet weak var lblCastBiography: ExpandableLabel!
    
    @IBOutlet weak var lblCastGender: UILabel!
    @IBOutlet weak var lblCastDateOfBirth: UILabel!
    @IBOutlet weak var lblCastPlaceOfBirth: UILabel!
    @IBOutlet weak var lblCastKnownCredits: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: DetailsPersonViewModel
    
    init(viewModel: DetailsPersonViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "DetailsPersonViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViews()
        bindViewModel()
        viewModel.getPersonDetails()
    }
    
    func configViews(){
        title = viewModel.screenTitle
        castImageView.round()
    }
    
    func populateValues(){
        activityIndicator.stopAnimating()
        if let castData = viewModel.personDetails{
            lblCastName.text = castData.name
            
            lblCastBiography.text = castData.biography
            lblCastBiography.numberOfLines = 10
            lblCastBiography.collapsedAttributedLink = NSAttributedString(string: "Read More")
            lblCastBiography.expandedAttributedLink = NSAttributedString(string: "Read Less")
            lblCastBiography.delegate = self
            
            if let path = castData.profileImage{
                castImageView.sd_setImage(with: path)
            }
            else{
                castImageView.image = UIImage(named: castData.gender == 2 ? maleAvatar : femaleAvatar)
            }
            
            lblCastGender.text = castData.gender == 2 ? "Male" : "Female"
            lblCastDateOfBirth.text = castData.birthday
            lblCastPlaceOfBirth.text = castData.placeOfBirth
            lblCastKnownCredits.text = castData.knownForDepartment
            
            collectionView.reloadData()
        }
    }
    
    func bindViewModel(){
        viewModel.isLoadingPersonDetails.bind { [weak self] isLoaded in
            guard let isLoaded = isLoaded, let self = self else { return }
            if isLoaded{
                self.activityIndicator.startAnimating()
            }
            else{
                self.populateValues()
            }
        }
    }

}


extension DetailsPersonViewController: ExpandableLabelDelegate{
    func willExpandLabel(_ label: ExpandableLabel) {
        print(#function)
    }
    
    func didExpandLabel(_ label: ExpandableLabel) {
        print(#function)
    }
    
    func willCollapseLabel(_ label: ExpandableLabel) {
        print(#function)
    }
    
    func didCollapseLabel(_ label: ExpandableLabel) {
        print(#function)
    }
}
