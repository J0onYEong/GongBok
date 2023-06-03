//
//  ApiRequest.swift
//  GongBok
//
//  Created by 최준영 on 2023/05/21.
//

import Foundation
import Alamofire

enum APIUrl: String {
    static private let baseUrl = "http://43.202.26.221:8080/"
    
    case kakaoLoginWeb = "oauth2/authorization/kakao"
    case personalData = "api/member"
    
    func getFullString() -> String {
        Self.baseUrl + self.rawValue
    }
}

enum RequestError: String, Error {
    case tokenUnavailable = "토큰이 로컬저장소에 존재하지 않습니다."
    case badUrl = "url에 문제가 발생했습니다."
    case noData = "데이터가 없습니다"
    case decodingError = "디코딩과정에서 문제가 발생했습니다."
    case encodingError = "인코딩과정에서 문제가 발생했습니다."
    case requestError = "요청 오류가 발생힜습니다."
}

struct NoReponseBody: Decodable { }
    
struct HTTPRequest {
    
    static let shared = HTTPRequest()
    
    private init() { }
    
    func requestWithAccessToken<Recieve: Decodable>(url: APIUrl, method: HTTPMethod, reponseType: Recieve.Type, sendData: Encodable?, completion: @escaping (Result<Recieve, RequestError>) -> ()) {
        guard let accessToken = FileController.shared.getData(.authorizationData, type: ServerAuthDataResponse.self)?.accessToken else {
            completion(.failure(.tokenUnavailable))
            return;
        }
        guard let finalUrl = URL(string: url.getFullString()) else {
            completion(.failure(.badUrl))
            return;
        }
        var request = URLRequest(url: finalUrl)
        request.httpMethod = method.rawValue
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        if let data = sendData {
            if let encoded = try? JSONEncoder().encode(data) {
                request.httpBody = encoded
            } else {
                completion(.failure(.encodingError))
            }
        }
        AF.request(request).responseDecodable(of: Recieve.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure( _ ):
                completion(.failure(.requestError))
            }
        }
    }
}
