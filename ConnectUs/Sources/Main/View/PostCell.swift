//
//  PostCell.swift
//  ConnectUs
//
//  Created by 김지수 on 2023/01/25.
//

import UIKit
import SnapKit
import Kingfisher

class PostCell: UITableViewCell {
    
    var viewModel: PostViewModel?
    var imageSize: Int = 60
    
    private var profileImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private var spacingView = UIView()
    
    private var userIdLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    private var updateTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .light)
        label.textColor = .gray
        return label
    }()
    
    private var bodyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .label
        return label
    }()
    
    lazy var userStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        return stack
    }()
    
    lazy var bodyStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        return stack
    }()
    
    lazy var imageStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        return stack
    }()
    
    lazy var postStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        return stack
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = UIImage()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure() {
        guard let vm = viewModel else { return }
        
        setupLayout()
        
        userIdLabel.text = vm.postResult.userId
        updateTimeLabel.text = vm.postResult.updateAt
        bodyLabel.text = vm.postResult.content
        profileImageView.kf.setImage(with: URL(string: vm.postResult.profileImgUrl ?? ""))
    }
    
    private func setupLayout() {
        self.contentView.addSubview(postStack)
        
        [userIdLabel, updateTimeLabel].forEach {
            userStack.addArrangedSubview($0)
        }
        [userStack, bodyLabel].forEach {
            bodyStack.addArrangedSubview($0)
        }
        [profileImageView, spacingView].forEach {
            imageStack.addArrangedSubview($0)
        }
        [imageStack, bodyStack].forEach {
            postStack.addArrangedSubview($0)
        }
        
        postStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        imageStack.snp.makeConstraints { make in
            make.width.equalTo(imageSize)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.height.equalTo(profileImageView.snp.width)
        }
        
        profileImageView.layer.cornerRadius = CGFloat(imageSize / 2)
        profileImageView.clipsToBounds = true
    }
}
