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
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = ColorPreset.background.colors
        tableView.separatorStyle = .none
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.postViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostCell else { return UITableViewCell() }
        cell.viewModel = viewModel.getCellViewModel(indexpath: indexPath)
        cell.configure()
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
}

