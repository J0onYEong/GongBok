//
//  SubjectViewModel.swift
//  GongBok
//
//  Created by 최준영 on 2023/07/04.
//

import SwiftUI

extension Array where Element == SubjectViewModel {
    subscript(id: Int) -> SubjectViewModel? {
        get {
            let tar = self.filter { e in
                e.id == id
            }
            return tar.isEmpty ? nil : tar.first
        }
    }
}

class SubjectViewModel: Hashable {
    static func == (lhs: SubjectViewModel, rhs: SubjectViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    var name: String
    var id: Int
    var weekList: [Int] = []
    
    init(name: String, id: Int) {
        self.name = name
        self.id = id
    }
    
    func getWeekList(completion: @escaping () -> ()) {
        HTTPRequest.shared.requestWithAccessToken(urlStr: APIUrl.subjectWeek(to: self.id), method: .get, reponseType: [Int].self, sendData: nil) { result in
            switch (result) {
            case .success(let data):
                guard let uwp = data else { return; }
                self.weekList = uwp
                completion()
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.name)
        hasher.combine(self.id)
    }
}
