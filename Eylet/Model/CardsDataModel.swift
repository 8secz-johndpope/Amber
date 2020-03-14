//
//  CardsDataModel.swift
//  Eylet
//
//  Created by Temporary on 2/8/20.
//  Copyright © 2020 Temporary. All rights reserved.
//

import Foundation


class CardsDataModel {
    var image: String
    var goodsName: String
    var price: String
    var brandName: String
    
    
    init(image: String, goodsName: String, price: String, brandName: String) {
        self.image = image
        self.goodsName = goodsName
        self.price = price
        self.brandName = brandName
    }
}



// MARK: - Item
struct Item {
    let image: String
    let brandName: String
    let goodsName: String
    let price: String
}
