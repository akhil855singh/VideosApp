//
//  VideoListingTableViewCell.swift
//  VideoApp
//
//  Created by Akhil Singh on 27/01/20.
//  Copyright © 2020 Akhil Singh. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation
import SDWebImage

class VideoListingTableViewCell: UITableViewCell, ASAutoPlayVideoLayerContainer {

    @IBOutlet weak var userProfileContainerView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var thumbImageView: UIImageView!
    
    var selectedVideo:VideoListing?
        
    var playerController: ASVideoPlayerController?
    var videoLayer: AVPlayerLayer = AVPlayerLayer()
    var videoURL: String? {
        didSet {
            if let videoURL = videoURL {
                ASVideoPlayerController.sharedVideoPlayer.setupVideoFor(url: videoURL)
            }
            videoLayer.isHidden = videoURL == nil
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        makeViewRounded(userImageView)
        videoLayer.backgroundColor = UIColor.clear.cgColor
        videoLayer.videoGravity = AVLayerVideoGravity.resize
        thumbImageView.layer.addSublayer(videoLayer)
        selectionStyle = .none
    }
    
    private func addGradiantToView(){
        let gradient: CAGradientLayer = CAGradientLayer()

        gradient.colors = [UIColor.blue.cgColor, UIColor.red.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.userProfileContainerView.frame.size.width, height: self.userProfileContainerView.frame.size.height)

        self.userProfileContainerView.layer.insertSublayer(gradient, at: 0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width: CGFloat = bounds.size.width
        let height: CGFloat = bounds.size.height
        videoLayer.frame = CGRect(x: 0, y: 0, width: width, height: height)
    }
    
    func visibleVideoHeight() -> CGFloat {
        let videoFrameInParentSuperView: CGRect? = self.superview?.superview?.convert(thumbImageView.frame, from: thumbImageView)
        guard let videoFrame = videoFrameInParentSuperView,
            let superViewFrame = superview?.frame else {
                return 0
        }
        let visibleVideoFrame = videoFrame.intersection(superViewFrame)
        return visibleVideoFrame.size.height
    }
    
    func updateViewBasedOnVideoData(_ video:VideoListing){
        self.selectedVideo = video
        print("video",video.videoUrl ?? "")
        self.videoURL = video.videoUrl
        self.userNameLabel.text = video.name
        self.timeLabel.text = video.time
        self.userImageView.sd_setImage(with: URL(string: video.imageUrl ?? "")) { (userImage, error, cacheType, imageUrl) in
            
        }
        
    }
}
