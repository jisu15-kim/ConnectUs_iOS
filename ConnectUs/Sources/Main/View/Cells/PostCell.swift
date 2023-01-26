//
//  PostCell.swift
//  ConnectUs
//
//  Created by 김지수 on 2023/01/25.
//

import UIKit
import SnapKit
import Kingfisher

class PostCell: UICollectionViewCell {
    
    var viewModel: PostViewModel?
    var imageSize: Int = 60
    var infoStackSpacingHeight = 10
    
    private var profileImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private var spacingView1 = UIView()
    private var spacingView2 = UIView()
    private var spacingview3 = UIView()
    
    private var userIdLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    private var bodyImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private var updateTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .light)
        label.textColor = .gray
        return label
    }()
    
    private var bodyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .label
        label.contentMode = .topLeft
        label.numberOfLines = 0
        return label
    }()
    
    lazy var infoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        return stack
    }()
    
    lazy var userStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 20
        return stack
    }()
    
    lazy var bodyStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 15
        return stack
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = UIImage()
        bodyImageView.image = UIImage()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = ColorPreset.background.colors
        contentView.backgroundColor = ColorPreset.background.colors
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15))
        setupCellLayout()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCellLayout() {
        contentView.setViewShadow(backView: self)
    }
    
    func configure() {
        guard let vm = viewModel else { return }
        
        setupLayout()
        
        userIdLabel.text = vm.postResult.userId
        updateTimeLabel.text = vm.postResult.updateAt
        bodyLabel.text = vm.postResult.content
        profileImageView.kf.setImage(with: URL(string: vm.postResult.profileImgUrl ?? ""))
        bodyImageView.kf.setImage(with: URL(string: vm.postResult.postImgRes?[0].postImgUrl ?? ""))
    }
    
    private func setupLayout() {
        self.contentView.addSubview(bodyStack)
        
        [spacingView1 ,userIdLabel, updateTimeLabel, spacingView2].forEach {
            infoStack.addArrangedSubview($0)
        }
        [profileImageView, infoStack].forEach {
            userStack.addArrangedSubview($0)
        }
        [userStack, bodyLabel, bodyImageView, spacingview3].forEach {
            bodyStack.addArrangedSubview($0)
        }
        
        bodyStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(15)
        }
        
        userStack.snp.makeConstraints { make in
            make.height.equalTo(imageSize)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.width.equalTo(profileImageView.snp.height)
        }
        
        [spacingView1, spacingView2].forEach {
            $0.snp.makeConstraints { make in
                make.height.equalTo(infoStackSpacingHeight)
            }
        }
        
        bodyImageView.snp.makeConstraints { make in
            make.height.equalTo(bodyImageView.snp.width).multipliedBy(0.7)
        }
        
        profileImageView.layer.cornerRadius = CGFloat(imageSize / 2)
        profileImageView.clipsToBounds = true
        
        bodyImageView.layer.cornerRadius = 10
        bodyImageView.clipsToBounds = true
    }
}

extension UIView {
    func setViewShadow(backView: UIView) {
        backView.layer.masksToBounds = true
//        backView.layer.cornerRadius = 10
//        backView.layer.borderWidth = 1
        
        layer.masksToBounds = false
        layer.shadowOpacity = 0.6
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 6
        layer.cornerRadius = 10
    }
}
