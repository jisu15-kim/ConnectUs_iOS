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
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var viewModel: ProfileViewModel!
    
    private var subscriptions = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = ProfileViewModel()
        bind()
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
                }
            }.store(in: &subscriptions)
    }
}
