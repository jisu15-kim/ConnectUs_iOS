//
//  ViewController.swift
//  ConnectUs
//
//  Created by 김지수 on 2023/01/24.
//

import UIKit

class MainViewController: BaseViewController {
    
    private var models: [PostModel] = []
    private var viewModel: MainViewModel = MainViewModel()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupTableView()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = ColorPreset.background.colors
    }
    
    private func setupViewModel() {
        viewModel.getPosts()
        
        // reload tableview closure
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    private func setupTableView() {
        tableView.register(PostCell.self, forCellReuseIdentifier: "PostCell")
        tableView.register(DiscoverCell.self, forCellReuseIdentifier: "DiscoverCell")
        tableView.register(SearchBarHeaderView.self, forHeaderFooterViewReuseIdentifier: "SearchBarHeaderView")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = ColorPreset.background.colors
        tableView.separatorStyle = .none
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getNumberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        default:
            return viewModel.postViewModels.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DiscoverCell", for: indexPath) as? DiscoverCell else { return UITableViewCell() }
            cell.configure()
            cell.selectionStyle = .none
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostCell else { return UITableViewCell() }
            cell.viewModel = viewModel.getCellViewModel(indexpath: indexPath)
            cell.configure()
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return 200
        default:
            return 500
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 1:
            guard let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SearchBarHeaderView") as? SearchBarHeaderView else { return UIView() }
            cell.configure()
            return cell
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 1:
            return 50
        default:
            return 0
        }
    }
}

