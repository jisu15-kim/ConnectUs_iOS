//
//  MainViewModel.swift
//  ConnectUs
//
//  Created by 김지수 on 2023/01/25.
//

import UIKit
import Combine

class MainViewModel {
    
    init(results: [PostResult] = []) {
        postLists = CurrentValueSubject(results)
    }
    
    var postLists: CurrentValueSubject<[PostResult], Never>

    
    func getPosts() {
        NetworkService().getFeedsNetworkData { [weak self] posts in
            self?.postLists.send(posts)
        }
    }
    
    func getNumberOfSections() -> Int {
        return 3
    }
}
