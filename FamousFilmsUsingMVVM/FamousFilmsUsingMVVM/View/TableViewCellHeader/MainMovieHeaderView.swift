//
//  MainMovieHeaderView.swift
//  FamousFilmsUsingMVVM
//
//  Created by Haidar Bhatti on 15/03/2023.
//

import UIKit
import SJFluidSegmentedControl

class MainMovieHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var lblHeaderTitle: UILabel!
    @IBOutlet weak var segmentedBar: SJFluidSegmentedControl!
    
    var viewModel: MainMovieHeaderViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        segmentedBar.addBorder(color: .black, width: 1)
    }
    
    func configure(with viewModel: MainMovieHeaderViewModel){
        self.viewModel = viewModel
        self.populateValues()
        segmentedBar.dataSource = self
        segmentedBar.delegate = self
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) { [weak self] in
            self?.segmentedBar.reloadData()
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
        lblHeaderTitle.text = viewModel?.title
    }

}

extension MainMovieHeaderView: SJFluidSegmentedControlDataSource, SJFluidSegmentedControlDelegate{
    func numberOfSegmentsInSegmentedControl(_ segmentedControl: SJFluidSegmentedControl) -> Int {
        return viewModel?.numberOfSegments() ?? 0
    }
    
    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl, titleForSegmentAtIndex index: Int) -> String? {
        return viewModel?.titleForSegmentAt(index: index)
    }
        
    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl, didChangeFromSegmentAtIndex fromIndex: Int, toSegmentAtIndex toIndex:Int){
        let action = viewModel?.titleForSegmentAt(index: toIndex) ?? ""
        print("\(action)")
        viewModel?.delegate?.didTapButton(with: action)
    }
}
