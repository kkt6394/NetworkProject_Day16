//
//  NetworkManager.swift
//  NetworkProject_Day16
//
//  Created by 김기태 on 1/25/26.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func callRequest(keyword: String, start: Int, sort: Sort, completion: @escaping (Result<ShoppingData, NaverError>) -> Void) {
        let url = "https://openapi.naver.com/v1/search/shop.json"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.clientID,
            "X-Naver-Client-Secret": APIKey.clientSecret
        ]
        let param: Parameters = [
            "query": keyword,
            "display": 30,
            "start": start,
            "sort": sort
        ]
        
        AF.request(
            url,
            method: .get,
            parameters: param,
            encoding: URLEncoding.queryString,
            headers: header
        )
        .validate(statusCode: 200..<300)
        .responseDecodable(of: ShoppingData.self) {
            response in
            switch response.result {
                
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                let newError = self.handleNetworkError(response: response, error: error)
                completion(.failure(newError as! NaverError))
            }
            
        }
        
    }
    
    func handleNetworkError(response: DataResponse<ShoppingData, AFError>, error: AFError) -> Error {
        if let data = response.data,
           let naverError = try? JSONDecoder().decode(NaverAPIError.self, from: data) {
            print("코드: \(naverError.errorCode)", "내용: ,\(naverError.errorMessage)")
        }
        
        if let statusCode = response.response?.statusCode {
            switch statusCode {
                case 429:
                return NaverError.requestLimit
            case 500...599:
                return NaverError.serverMaintenance
            case 400, 401, 403, 404:
                return NaverError.apiError
            default:
                return NaverError.networkIssue
            
            }
        }
        if error.isSessionTaskError {
            return NaverError.networkIssue
        }
        
        return NaverError.apiError
        
    }
}

