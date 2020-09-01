//
//  Data.swift
//  parsingData
//
//  Created by nguyen viet hoang on 9/1/20.
//  Copyright © 2020 nguyen viet hoang. All rights reserved.
//

import Foundation
struct  ListPerSon : Codable{
    var data : [Person]
}
struct Person : Codable {
    let userName : String
    let image : String
    let location: String
    let age : Int
    let gender : String
}

