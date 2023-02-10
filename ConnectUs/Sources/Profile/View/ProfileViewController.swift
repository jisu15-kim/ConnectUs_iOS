//
//  ProfileViewController.swift
//  ConnectUs
//
//  Created by 김지수 on 2023/02/08.
//

import UIKit
import Combine
import Kingfisher

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var uvHeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var uvTopConstraints: NSLayoutConstraint!
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: ProfileViewModel!
    
    private var subscriptions = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = ProfileViewModel()
        bind()
        setupUI()
        setupCollectionView()
    }
    
    private func bind() {
        viewModel.user
            .receive(on: RunLoop.main)
            .sink { [weak self] result in
                dump(result)
                if let result = result {
                    self?.idLabel.text = "@\(result.id.name ?? "")"
                    self?.nameLabel.text = result.name.title
                    self?.profileImageView.kf.setImage(with: URL(string: result.picture.large))
                    self?.navigationItem.title = result.name.title
                }
            }.store(in: &subscriptions)
    }
    
    private func setupUI() {
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.layer.opacity = 0
        profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
        profileImageView.clipsToBounds = true
    }
    
    private func setupCollectionView() {
        collectionView.register(FollowInfoCell.self, forCellWithReuseIdentifier: "FollowInfoCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getCollectionViewNumberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FollowInfoCell", for: indexPath) as? FollowInfoCell else { return UICollectionViewCell() }
        cell.configure()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 200)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let height = uvHeightConstraints.constant
        
        if offsetY <= height {
            uvTopConstraints.constant = -offsetY
            self.navigationController?.navigationBar.layer.opacity = 0
            self.navigationController?.isNavigationBarHidden = false
        } else {
            self.navigationController?.navigationBar.layer.opacity = 1
        }
        
        let opacity = offsetY / height
        if opacity >= 0, opacity <= 1 {
            self.navigationController?.navigationBar.layer.opacity = Float(opacity)
        }
    }
}
