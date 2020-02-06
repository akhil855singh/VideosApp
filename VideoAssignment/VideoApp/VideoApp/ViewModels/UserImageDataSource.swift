//
//  UserImageDataSource.swift
//  VideoApp
//
//  Created by Akhil Singh on 06/02/20.
//  Copyright © 2020 Akhil Singh. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class GenericCollectionDataSource<T> : NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
}

class UserImageDataSource:GenericCollectionDataSource<PostsModel>,
                            UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    let cellsPerRow = 3
    let spaceBetweenCells = 3

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return data.value.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing = CGFloat(spaceBetweenCells+(cellsPerRow*spaceBetweenCells))
        return CGSize(width: (UIScreen.main.bounds.size.width - spacing)/CGFloat(cellsPerRow), height:(UIScreen.main.bounds.size.width-spacing)/CGFloat(cellsPerRow))
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "UserImageCollectionViewCell"
        guard let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? UserImageCollectionViewCell)
            else{
            return UICollectionViewCell()
        }
        let postAtIndex = data.value[indexPath.row]
        cell.userImageView.sd_setImage(with: URL(string: postAtIndex.imageUrl ?? "")) { (userImage, error, cacheType, imageUrl) in
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(spaceBetweenCells)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(spaceBetweenCells)
    }

}
