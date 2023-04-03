//
//  DetailsMovieViewController+CollectionView.swift
//  FamousFilmsUsingMVVM
//
//  Created by Haidar Bhatti on 03/04/2023.
//

import UIKit

extension DetailsMovieViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func setUpCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        registerCells()
    }
    
    func registerCells(){
        collectionView.register(CrewAndCastCollViewCell.register(), forCellWithReuseIdentifier: CrewAndCastCollViewCell.identifier)
    }
    
    func reloadCollectionView(){
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.noOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.noOfItemsInsection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CrewAndCastCollViewCell.identifier, for: indexPath) as! CrewAndCastCollViewCell
        let castData = viewModel.cellFor(ItemAt: indexPath.item)
        cell.setUpCell(castData: castData)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 105, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let id = viewModel.getPersonId(forItem: indexPath.item){
            self.openDetails(personId: id)
        }
    }
}
