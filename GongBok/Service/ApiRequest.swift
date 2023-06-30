//
//  ApiRequest.swift
//  GongBok
//
//  Created by 최준영 on 2023/05/21.
//

import Foundation
import Alamofire

struct APIUrl {
    
    private init() { }
    
    static let baseUrl = "http://43.202.26.221:8080/"
    static var kakaoLoginWeb: String { baseUrl + "oauth2/authorization/kakao" }
    static var personalData: String { baseUrl + "api/member" }
    static var addSubject: String { baseUrl + "api/review/subject" }
    static var getSubjects: String { baseUrl + "api/review/subjects" }

    //get - 특정 과목아이디의 차시들을 모두 불러옴, post - 특정과목에 week를 추가함
    static func subjectWeek(to: Int) -> String {
        return baseUrl + "api/review/subject/\(to)/week"
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
    
    func requestWithAccessToken<Recieve: Decodable>(urlStr: String, method: HTTPMethod, reponseType: Recieve.Type, sendData: Encodable?, completion: @escaping (Result<Recieve?, RequestError>) -> ()) {
        guard let accessToken = FileController.shared.getData(.authorizationData, type: ServerAuth.self)?.accessToken else {
            completion(.failure(.tokenUnavailable))
            return;
        }
        guard let finalUrl = URL(string: urlStr) else {
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
        
        
        if reponseType == NoReponseBody.self {
            AF.request(request).response { response in
                switch response.result {
                case .success:
                    completion(.success(nil))
                case .failure( _ ):
                    completion(.failure(.requestError))
                }
            }
        } else {
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
}
