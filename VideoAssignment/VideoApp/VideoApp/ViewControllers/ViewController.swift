//
//  ViewController.swift
//  VideoApp
//
//  Created by Akhil Singh on 27/01/20.
//  Copyright © 2020 Akhil Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let dataSource = VideoDataSource()
    
    lazy var viewModel:VideoViewModel = {
        let viewModal = VideoViewModel(dataSource: dataSource)
        return viewModal
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = dataSource
        self.tableView.delegate = dataSource
        dataSource.data.addAndNotify(observer: self) { [weak self] _ in
            self?.tableView.reloadData()
        }
        
        self.viewModel.onErrorHandling = { [weak self] error in
            let controller = UIAlertController(title: "An error occured", message: "Oops, something went wrong!", preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            self?.present(controller, animated: true, completion: nil)
        }
        
        NotificationCenter.default.addObserver(self,
        selector: #selector(self.appEnteredFromBackground),
        name:UIApplication.willEnterForegroundNotification, object: nil)
        
        self.viewModel.fetchVideos()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ASVideoPlayerController.sharedVideoPlayer.pausePlayeVideosFor(tableView: tableView)
    }
    
    @objc private func appEnteredFromBackground() {
        ASVideoPlayerController.sharedVideoPlayer.pausePlayeVideosFor(tableView: tableView, appEnteredFromBackground: true)
    }
}


