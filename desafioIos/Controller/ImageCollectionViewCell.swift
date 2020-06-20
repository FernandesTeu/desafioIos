//
//  ImageCollectionViewCell.swift
//  desafioIos
//
//  Created by Mateus Fernandes on 19/06/20.
//  Copyright © 2020 Mateus Fernandes. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageCat: UIImageView!
    static let reuseIdentifier = String(describing: ImageCollectionViewCell.self)
    
    func applyCatsImageFromUrl(url: String){
        guard let catsImageUrl = URL(string: url) else {return }
        DispatchQueue.global().async {
            guard let catsImageData = try? Data(contentsOf: catsImageUrl) else { return }
            let catImage = UIImage(data: catsImageData)
            if(catImage != nil){
                DispatchQueue.main.async {
                    self.imageCat.image = catImage
                    self.imageCat.adjustsImageSizeForAccessibilityContentSizeCategory = false
                    self.imageCat.isUserInteractionEnabled = false
                }
            }
        }
    }
}
