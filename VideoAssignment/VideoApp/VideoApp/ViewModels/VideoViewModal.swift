//
//  VideoViewModal.swift
//  VideoApp
//
//  Created by Akhil Singh on 28/01/20.
//  Copyright © 2020 Akhil Singh. All rights reserved.
//

import Foundation

struct VideoViewModel {
    
    weak var dataSource : GenericDataSource<VideoListing>?
    weak var service: VideoServiceProtocol?
    
    var onErrorHandling : ((ErrorResult?) -> Void)?
    
    init(service: VideoServiceProtocol = FileDataService.shared, dataSource : GenericDataSource<VideoListing>?) {
        self.dataSource = dataSource
        self.service = service
    }
    
    func fetchVideos() {
        
        guard let service = service else {
            onErrorHandling?(ErrorResult.custom(string: "Missing service"))
            return
        }
        
        service.fetchVideosForJson { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let converter) :
                    self.dataSource?.data.value = converter.videos
                case .failure(let error) :
                    self.onErrorHandling?(error)
                }
            }
        }
    }
}
