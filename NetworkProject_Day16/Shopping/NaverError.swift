//
//  NaverError.swift
//  NetworkProject_Day16
//
//  Created by 김기태 on 1/25/26.
//

import Foundation

struct NaverAPIError: Codable {
    let errorMessage: String
    let errorCode: String
}
