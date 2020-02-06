//
//  UserProfileViewModal.swift
//  VideoApp
//
//  Created by Akhil Singh on 30/01/20.
//  Copyright © 2020 Akhil Singh. All rights reserved.
//

import Foundation

struct UserProfileViewModal {
    
    weak var dataSource : GenericCollectionDataSource<PostsModel>?
    weak var service: VideoServiceProtocol?
    
    var onErrorHandling : ((ErrorResult?) -> Void)?
    var onSuccessfullParsing : ((UserProfileModel?) -> Void)?
    
    init(service: VideoServiceProtocol = FileDataService.shared, dataSource : GenericCollectionDataSource<PostsModel>?) {
        self.dataSource = dataSource
        self.service = service
    }
    
    func fetchUserProfile() {
        
        guard let service = service else {
            onErrorHandling?(ErrorResult.custom(string: "Missing service"))
            return
        }
        
        service.fetchUserProfileForJson { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let converter) :
                    self.onSuccessfullParsing?(converter)
                    self.dataSource?.data.value = converter.posts ?? [PostsModel]()
                case .failure(let error) :
                    self.onErrorHandling?(error)
                }
            }
        }
    }
}
