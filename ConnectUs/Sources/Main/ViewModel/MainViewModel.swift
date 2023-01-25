//
//  MainViewModel.swift
//  ConnectUs
//
//  Created by 김지수 on 2023/01/25.
//

import Foundation

class MainViewModel {
    
    var reloadTableView: (() -> Void)?
    
    var postLists = [PostResult]()
    var postViewModels = [PostViewModel]() {
        didSet {
            reloadTableView?()
        }
    }
    
    func getPosts() {
        NetworkService().getFeedsNetworkData { [weak self] posts in
            self?.fetchData(postResult: posts)
        }
    }
    
    func fetchData(postResult: [PostResult]) {
        postLists = postResult
        var viewModels = [PostViewModel]()
        postResult.forEach {
            viewModels.append(PostViewModel(postResult: $0))
        }
        self.postViewModels = viewModels
    }
    
    func getCellViewModel(indexpath: IndexPath) -> PostViewModel {
        return postViewModels[indexpath.row]
    }
}
