//
//  CardsDataModel.swift
//  Eylet
//
//  Created by Temporary on 2/8/20.
//  Copyright © 2020 Temporary. All rights reserved.
//

import Foundation


class CardsDataModel {
    var photoLink: String
    var name: String
    var price: Int
    var isMale: Bool
    var brand: String
    
    
    init(photoLink: String, name: String, price: Int, isMale: Bool, brand: String) {
        self.photoLink = photoLink
        self.name = name
        self.price = price
        self.isMale = isMale
        self.brand = brand
    }
}
