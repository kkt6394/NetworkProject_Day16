//
//  NaverError.swift
//  NetworkProject_Day16
//
//  Created by 김기태 on 1/25/26.
//

import Foundation

enum NaverError: Error {
    case networkIssue
    case serverMaintenance
    case requestLimit
    case apiError
    
    var alertMessage: String {
        switch self {
        case .networkIssue:
            return "인터넷 연결이 불안정합니다. 네트워크 상태를 확인하고 다시 시도해 주세요."
        case .serverMaintenance:
            return "현재 서비스 점검 중입니다. 잠시 후 다시 이용해 주세요."
        case .requestLimit:
            return "오늘 이용 가능한 횟수를 모두 사용했습니다. 내일 다시 시도해 주세요."
        case .apiError:
            return "검색 결과를 불러오는 중 문제가 발생했습니다. 다른 검색어로 시도해 보세요."
        }
    }
}

struct NaverAPIError: Codable {
    let errorMessage: String
    let errorCode: String
}
