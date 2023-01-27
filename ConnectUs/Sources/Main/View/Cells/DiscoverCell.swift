//
//  DiscoverCell.swift
//  ConnectUs
//
//  Created by 김지수 on 2023/01/26.
//

import UIKit
import Kingfisher
import SnapKit

class DiscoverCell: UICollectionViewCell {
    
    var imageUrl: String?
    
    private var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
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
        setupLayout()
        self.imageView.kf.setImage(with: URL(string: imageUrl ?? ""))
    }
    
    func setupLayout() {
        self.contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
