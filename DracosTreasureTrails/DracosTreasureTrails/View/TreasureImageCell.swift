//
//  ImageCell.swift
//  DracosTreasureTrails
//
//  Created by Draco’s Treasure Trails on 2024/12/24.
//

import UIKit

class TreasureImageCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!

    func configure(with imageName: String) {
        imageView.image = UIImage(named: imageName)
        imageView.layer.cornerRadius = 8.0
    }
}
