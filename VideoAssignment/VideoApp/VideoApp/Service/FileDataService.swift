//
//  FileDataService.swift
//  VideoApp
//
//  Created by Akhil Singh on 28/01/20.
//  Copyright © 2020 Akhil Singh. All rights reserved.
//

import Foundation

protocol VideoServiceProtocol : class {
    func fetchVideosForJson(_ completion: @escaping ((Result<Converter, ErrorResult>) -> Void))
    func fetchUserProfileForJson(_ completion: @escaping ((Result<UserProfileModel, ErrorResult>) -> Void))
}

final class FileDataService : VideoServiceProtocol {
    
    static let shared = FileDataService()
    
    func fetchVideosForJson(_ completion: @escaping ((Result<Converter, ErrorResult>) -> Void)) {
        
        // giving a sample json file
        guard let data = FileManager.readJson(forResource: "feed") else {
            completion(Result.failure(ErrorResult.custom(string: "No file or data")))
            return
        }
        
        do {
               let decoder = JSONDecoder()
               let videos = try decoder.decode(Converter.self, from: data)
               completion(Result.success(videos))
               
           } catch let err {
               print("Err", err)
            completion(Result.failure(ErrorResult.custom(string: err.localizedDescription)))
        }
    }
    
    func fetchUserProfileForJson(_ completion: @escaping ((Result<UserProfileModel, ErrorResult>) -> Void)) {
        
        guard let data = FileManager.readJson(forResource: "userprofile") else {
            completion(Result.failure(ErrorResult.custom(string: "No file or data")))
            return
        }
        
        do {
               let decoder = JSONDecoder()
               let userProfile = try decoder.decode(UserProfileModel.self, from: data)
               completion(Result.success(userProfile))
               
           } catch let err {
               print("Err", err)
            completion(Result.failure(ErrorResult.custom(string: err.localizedDescription)))
        }
    }
}


extension FileManager {
    
    static func readJson(forResource fileName: String ) -> Data? {
        
        let bundle = Bundle(for: FileDataService.self)
        if let path = bundle.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {
                // handle error
            }
        }
        
        return nil
    }
}
