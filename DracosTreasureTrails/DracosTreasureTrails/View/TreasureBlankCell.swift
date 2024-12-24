//
//  BlankCell.swift
//  DracosTreasureTrails
//
//  Created by Draco’s Treasure Trails on 2024/12/24.
//

import UIKit

class TreasureBlankCell: UICollectionViewCell {
    @IBOutlet weak var letterLabel: UILabel!

    func configure(with letter: String) {
        letterLabel.text = letter
        letterLabel.textColor = letter == "_" ? .black : .black
        letterLabel.textAlignment = .center
        letterLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        letterLabel.frame = bounds // Ensure the label takes the entire cell space
    }
}
