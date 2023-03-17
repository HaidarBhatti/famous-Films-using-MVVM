//
//  Protocols.swift
//  FamousFilmsUsingMVVM
//
//  Created by Haidar Bhatti on 17/03/2023.
//

import Foundation

protocol HeaderViewModelDelegate: AnyObject {
    func didTapButton(with action: String)
}
