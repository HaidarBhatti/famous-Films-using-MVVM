//
//  DetailsPersonViewController+CollectionView.swift
//  FamousFilmsUsingMVVM
//
//  Created by Haidar Bhatti on 03/04/2023.
//

import UIKit

extension DetailsPersonViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func setUpCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        registerCell()
    }
    
    func registerCell(){
        collectionView.register(MovieCollViewCell.register(), forCellWithReuseIdentifier: MovieCollViewCell.identifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollViewCell.identifier, for: indexPath) as! MovieCollViewCell
        cell.setUpCell(castData: viewModel.cellFor(item: indexPath.item))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 105, height: 180)
    }
    
}
