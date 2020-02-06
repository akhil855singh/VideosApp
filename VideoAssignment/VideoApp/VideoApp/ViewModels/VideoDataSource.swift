//
//  VideoDataSource.swift
//  VideoApp
//
//  Created by Akhil Singh on 28/01/20.
//  Copyright © 2020 Akhil Singh. All rights reserved.
//

import Foundation
import UIKit

class GenericDataSource<T> : NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
}

class VideoDataSource : GenericDataSource<VideoListing>, UITableViewDataSource,UITableViewDelegate {
    
    private var localTableView:UITableView?
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        localTableView = tableView
        return data.value.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VideoListingTableViewCell", for: indexPath) as? VideoListingTableViewCell
            else{
                return UITableViewCell()
        }
        
        let video = self.data.value[indexPath.row]
        cell.updateViewBasedOnVideoData(video)
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let videoCell = cell as? ASAutoPlayVideoLayerContainer, let _ = videoCell.videoURL {
            ASVideoPlayerController.sharedVideoPlayer.removeLayerFor(cell: videoCell)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pausePlayVideos()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            pausePlayVideos()
        }
    }
    
    private func pausePlayVideos(){
        if let tableView = localTableView{
        ASVideoPlayerController.sharedVideoPlayer.pausePlayeVideosFor(tableView: tableView)
        }
    }
}
