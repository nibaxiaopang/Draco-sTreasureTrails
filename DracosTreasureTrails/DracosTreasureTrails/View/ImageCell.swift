//
//  ImageCell.swift
//  DracosTreasureTrails
//
//  Created by jin fu on 2024/12/24.
//

import UIKit

class ImageCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!

    func configure(with imageName: String) {
        imageView.image = UIImage(named: imageName)
        imageView.layer.cornerRadius = 8.0
    }
}
