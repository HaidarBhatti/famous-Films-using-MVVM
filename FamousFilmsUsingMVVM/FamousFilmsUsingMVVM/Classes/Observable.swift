//
//  Observable.swift
//  FamousFilmsUsingMVVM
//
//  Created by Haidar Bhatti on 07/03/2023.
//

import Foundation

class Observable<T>{
    
    private var listener: ((T?) -> Void)?
    
    var value: T?{
        didSet{
            DispatchQueue.main.async {
                self.listener?(self.value)
                print("\(self.value)")
            }
        }
    }
    
    init(_ value: T?){
        self.value = value
    }
    
    func bind(_ listener: @escaping ((T?) -> Void)){
        listener(value)
        self.listener = listener
    }
    
}
