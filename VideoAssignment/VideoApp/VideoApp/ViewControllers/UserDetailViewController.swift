//
//  UserDetailViewController.swift
//  VideoApp
//
//  Created by Akhil Singh on 06/02/20.
//  Copyright © 2020 Akhil Singh. All rights reserved.
//

import UIKit
import SDWebImage

class UserDetailViewController: UIViewController {

    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let dataSource = UserImageDataSource()
    
    lazy var viewModel:UserProfileViewModal = {
           let viewModal = UserProfileViewModal(dataSource: dataSource)
           return viewModal
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = dataSource
        self.collectionView.delegate = dataSource
        
       dataSource.data.addAndNotify(observer: self) { [weak self] _ in
            self?.collectionView.reloadData()
        }
        
        self.viewModel.onErrorHandling = { [weak self] error in
            let controller = UIAlertController(title: "An error occured", message: "Oops, something went wrong!", preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            self?.present(controller, animated: true, completion: nil)
        }
        
        self.viewModel.onSuccessfullParsing = { [weak self] userProfile in
            if let profile = userProfile{
                self?.updateUserProfileBasedOnData(profile)
            }
        }
        
        self.viewModel.fetchUserProfile()
        makeViewRounded(self.userImageView)
        makeViewRounded(self.closeButton)
        
        
        

        // Do any additional setup after loading the view.
    }
    
    private func updateUserProfileBasedOnData(_ userProfile:UserProfileModel){
        self.userImageView.sd_setImage(with: URL(string: userProfile.imageUrl ?? "")) { (userImage, error, cacheType, imageUrl) in
        }
        self.userNameLabel.text = userProfile.name
        self.titleLabel.text = userProfile.title
        self.descriptionLabel.text = userProfile.description
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

