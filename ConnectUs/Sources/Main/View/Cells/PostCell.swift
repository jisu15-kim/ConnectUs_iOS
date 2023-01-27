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
    private var spacingview3: UIView = {
        let view = UIView()
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        return view
    }()
    
    private var userIdLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    private var bodyImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        view.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
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
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .label
        label.contentMode = .topLeft
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.required, for: .vertical)
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
    
    //MARK: - 하단 ICON 들 (좋아요 / 코멘트)
    
    var likeIcon: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(systemName: "heart.fill")
        return view
    }()
    
    var likeCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    var commentIcon: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(systemName: "ellipsis.message.fill")
        return view
    }()
    
    var commentCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    var iconSpacing1 = UIView()
    var iconSpacing2 = UIView()
    
    var shareIcon: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(systemName: "arrowshape.turn.up.forward.fill")
        view.setContentCompressionResistancePriority(.required, for: .vertical)
        return view
    }()
    
    lazy var iconsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 5
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
        likeCountLabel.text = "\(vm.postResult.postLikeCount)"
        commentCountLabel.text = "\(vm.postResult.commentCount ?? 0)"

        // KINGFISHER 이미지 셋업
        profileImageView.kf.indicatorType = .activity
        profileImageView.kf.setImage(with: URL(string: vm.postResult.profileImgUrl ?? ""), placeholder: UIImage(named: "defaultProfile"))
        
        bodyImageView.kf.indicatorType = .activity
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
        [likeIcon, likeCountLabel, iconSpacing1, commentIcon, commentCountLabel, iconSpacing2, shareIcon].forEach {
            iconsStack.addArrangedSubview($0)
        }
        [userStack, bodyLabel, bodyImageView, iconsStack, spacingview3].forEach {
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
        [likeIcon, commentIcon, shareIcon].forEach { icon in
            icon.snp.makeConstraints { make in
                make.width.equalTo(icon.snp.height)
            }
            icon.tintColor = .white
        }
        
        iconSpacing1.snp.makeConstraints { make in
            make.width.equalTo(15)
        }
        bodyImageView.snp.makeConstraints { make in
            make.height.lessThanOrEqualTo(bodyImageView.snp.width).multipliedBy(0.65)
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
