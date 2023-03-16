//
//  Date+Extension.swift
//  FamousFilmsUsingMVVM
//
//  Created by Haidar Bhatti on 16/03/2023.
//

import Foundation

extension Date{
    func getFormattedDate(dateFormat: DateFormat) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = dateFormat.rawValue
        let qwer = dateformat.string(from: self)
        return qwer
    }
}
