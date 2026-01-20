//
//  Picsum.swift
//  NetworkProject_Day16
//
//  Created by 김기태 on 1/20/26.
//

import Foundation

struct Picsum: Decodable {
    let author: String
    let width: Int
    let height: Int
    let download_url: String
}
