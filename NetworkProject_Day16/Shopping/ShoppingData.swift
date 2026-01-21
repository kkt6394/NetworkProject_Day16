//
//  ShoppingData.swift
//  NetworkProject_Day16
//
//  Created by 김기태 on 1/21/26.
//

import Foundation

struct ShoppingData: Decodable {
    let total: Int
    let items: [Items]
}

extension ShoppingData {
    struct Items: Decodable {
        let image: String
        let mallName: String
        let title: String
        let lprice: String
    }
}
