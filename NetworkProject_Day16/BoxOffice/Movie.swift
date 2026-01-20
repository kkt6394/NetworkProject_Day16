//
//  Movie.swift
//  NetworkProject_Day16
//
//  Created by 김기태 on 1/20/26.
//

import Foundation

struct Movie: Decodable {
    let boxOfficeResult: BoxOfficeResult
}

extension Movie {
    struct BoxOfficeResult: Decodable {
        let dailyBoxOfficeList: [DailyBoxOfficeList]
    }
}

extension Movie.BoxOfficeResult {
    struct DailyBoxOfficeList: Decodable {
        let rank: String
        let movieNm: String
        let openDt: String
    }
}





