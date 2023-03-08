//
//  UIView+Extension.swift
//  FamousFilmsUsingMVVM
//
//  Created by Haidar Bhatti on 07/03/2023.
//

import UIKit

extension UIView{
    func round(_ radius: CGFloat = 10){
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func addBorder(color: UIColor, width: CGFloat){
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
}
