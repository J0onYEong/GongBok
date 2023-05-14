//
//  BundleExtension.swift
//  GongBok
//
//  Created by 최준영 on 2023/05/14.
//

import Foundation

extension Bundle {
    var apiKey: String? {
        guard let file = self.path(forResource: "Secrets", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let key = resource["API_KEY"] as? String else {
            print("API_KEY가져오기 실패")
            return nil
        }
        return key
    }
}
