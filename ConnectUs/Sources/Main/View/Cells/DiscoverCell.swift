//
//  DiscoverCell.swift
//  ConnectUs
//
//  Created by 김지수 on 2023/01/26.
//

import UIKit

class DiscoverCell: UICollectionViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure() {
        self.contentView.backgroundColor = .gray
    }
}
