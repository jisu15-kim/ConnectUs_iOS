//
//  SearchBarCell.swift
//  ConnectUs
//
//  Created by 김지수 on 2023/01/26.
//

import UIKit
import SnapKit

class SearchBarHeaderView: UICollectionReusableView {
    
    var searchBar: UISearchBar = {
        var search = UISearchBar()
        return search
    }()
    
    var profileView = UIView()
    
    var profileImageView: UIImageView = {
        var view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    lazy var stackView: UIStackView = {
        var stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 5
        return stack
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = ColorPreset.background.colors
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    func configure() {
        self.addSubview(stackView)
        profileView.addSubview(profileImageView)
        [searchBar, profileView].forEach {
            stackView.addArrangedSubview($0)
        }
        
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        profileImageView.clipsToBounds = true
        
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(self).inset(5)
            make.trailing.equalTo(self).inset(15)
            make.top.bottom.equalTo(self)
        }
        profileView.snp.makeConstraints { make in
            make.width.equalTo(profileView.snp.height)
        }
        profileImageView.snp.makeConstraints { make in
            make.edges.equalTo(profileView).inset(8)
            make.width.equalTo(profileImageView.snp.height)
        }
        
        profileImageView.image = UIImage(named: "myProfile")
        
        setupUI()
        setupSearchBar()
    }
    
    func setupUI() {
        
    }
    
    func setupSearchBar() {
//        searchBar.backgroundColor = ColorPreset.background.colors
        searchBar.tintColor = ColorPreset.accent00.colors
        searchBar.barTintColor = ColorPreset.background.colors
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search"
        
        searchBar.searchTextField.layer.cornerRadius = 15
        searchBar.searchTextField.clipsToBounds = true
        searchBar.searchTextField.backgroundColor = #colorLiteral(red: 0.1884286404, green: 0.208476007, blue: 0.2550091743, alpha: 1)
    }
}
