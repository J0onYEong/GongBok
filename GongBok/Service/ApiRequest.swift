//
//  ApiRequest.swift
//  GongBok
//
//  Created by 최준영 on 2023/05/21.
//

import Foundation


struct APIUrl {
    private static var baseUrl = "http://43.202.26.221:8080/"
    static var kakaoLoginWeb: String {
        return baseUrl+"oauth2/authorization/kakao"
    }
    
    static var personalDataSave: String {
        return baseUrl+"api/member"
    }
    
    static var testGoogle: String {
        return "https://www.google.co.kr/?hl=ko"
    }
    
    private init() { }
}
    


/*
 api/subject
    메서드: GET
    받을데이터 subject_name
 
 api/review/week_num
    매서드: GET
    받을데이터: week_num
 
 api/review/content
    매서드: PATCH
    받을데이터: content 받아오기
 
 api/quiz/descriptive
    매서드: GET
    세부사항 없음
 
 api/reference
    매서드: GET
    받을데이터: 관려자료(하이퍼링크) 받아오기
 */
