//
//  String+Extension.swift
//  FamousFilmsUsingMVVM
//
//  Created by Haidar Bhatti on 16/03/2023.
//

import Foundation

extension String {
    func toFormatedDate(withFormat format: DateFormat)-> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        let date = dateFormatter.date(from: self)
        return date
    }
}
