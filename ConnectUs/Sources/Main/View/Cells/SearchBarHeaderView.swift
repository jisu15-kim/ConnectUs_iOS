//
//  SearchBarCell.swift
//  ConnectUs
//
//  Created by 김지수 on 2023/01/26.
//

import UIKit
import SnapKit

class SearchBarHeaderView: UITableViewHeaderFooterView {
    
    var searchBar: UISearchBar = {
        var search = UISearchBar()
        return search
    }()
    
    var profileImageView: UIImageView = {
        var view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    lazy var stackView: UIStackView = {
        var stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20
        return stack
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundConfiguration = UIBackgroundConfiguration.clear()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 15))
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure() {

        self.contentView.addSubview(stackView)
        [searchBar, profileImageView].forEach {
            stackView.addArrangedSubview($0)
        }
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        profileImageView.snp.makeConstraints { make in
            make.width.equalTo(profileImageView.snp.height)
        }
        profileImageView.layer.cornerRadius = self.contentView.frame.height / 2
        profileImageView.clipsToBounds = true
        profileImageView.image = UIImage(named: "myProfile")
        
        setupSearchBar()
    }
    
    func setupSearchBar() {
        searchBar.backgroundColor = ColorPreset.background.colors
        searchBar.barTintColor = ColorPreset.background.colors
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "검색하세요"
    }
}
