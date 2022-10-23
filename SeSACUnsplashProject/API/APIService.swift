//
//  APIService.swift
//  SeSACUnsplashProject
//
//  Created by CHOI on 2022/10/23.
//

import Alamofire

class APIService {
    static func randomPhoto(completion: @escaping (RandomPhoto?, Int?, Error?) -> Void) {
        let url = "\(APIKey.randomURL)"
        let header: HTTPHeaders = ["Authorization": APIKey.authorization]
        
        AF.request(url, method: .get, headers: header).responseDecodable(of: RandomPhoto.self) { response in
            let statusCode = response.response?.statusCode
            
            switch response.result {
            case .success(let value): completion(value, statusCode, nil)
            case .failure(let error): completion(nil, statusCode, error)
            }
        }
    }
    
    private init() { }
}
