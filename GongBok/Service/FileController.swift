//
//  LoadFile.swift
//  SocialLoginTestApp
//
//  Created by 최준영 on 2023/05/12.
//

import Foundation

enum FileName: String {
    case authorizationData = "authorizationData"
}

struct FileController {
    private init() { }
    
    static let shared = FileController();
    
    func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    
    // MARK: - 데이터 CRUD
    func saveData(_ filename: FileName, _ data: Encodable) {
        guard let encodedData = try? JSONEncoder().encode(data) else {
            print("data enocoding error")
            return
        }
        
        do {
            let path = getDocumentDirectory().appendingPathComponent("\(filename.rawValue).json")
            try encodedData.write(to: path, options: [.atomic])
        } catch {
            print("error occurs on data saving process")
        }
    }
    
    func getData<T>(_ filename: FileName, type: T.Type) -> T? where T: Decodable {
        let path = getDocumentDirectory().appendingPathComponent("\(filename.rawValue).json")
        do {
            let data = try Data(contentsOf: path)
            let decoded = try JSONDecoder().decode(T.self, from: data);
            return decoded
        } catch let error as NSError {
            switch error.code {
            case 260:
                print("파일이 아직 존재하지 않음")
            default:
                print(error.localizedDescription)
            }
        }
        return nil;
    }
    
    func deleteData(_ filename: FileName) {
        let path = getDocumentDirectory().appendingPathComponent("\(filename.rawValue).json")
        do {
            try FileManager.default.removeItem(at: path)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
}
    
