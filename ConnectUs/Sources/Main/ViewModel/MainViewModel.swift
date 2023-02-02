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
    
    enum ScrollUpButtonState: CaseIterable {
        case show
        case hide
        
        var alpha: CGFloat {
            switch self {
            case .show:
                return 1.0
            case .hide:
                return 0
            }
        }
    }
    
    var scrollButtonState = CurrentValueSubject<ScrollUpButtonState, Never>(.hide)
    
    private var offsetY: Float = 600.0
    
    var postLists: CurrentValueSubject<[PostResult], Never>
    
    func getNumberOfSections() -> Int {
        return 3
    }
    
    //MARK: - Network 통신
    func getPosts() {
        NetworkService().getFeedsNetworkData { [weak self] posts in
            self?.postLists.send(posts)
        }
    }
    
    //MARK: - ScrollView Offset에 따른 Button Show / Hide
    func scrollViewOffsetY(_ offsetY: CGFloat) {
        if Float(offsetY) >= self.offsetY {
            if scrollButtonState.value == .hide {
                scrollButtonState.send(.show)
            }
        } else {
            if scrollButtonState.value == .show {
                scrollButtonState.send(.hide)
            }
        }
    }
}
