//
//  ProfileViewModel.swift
//  ConnectUs
//
//  Created by 김지수 on 2023/02/08.
//

import Foundation
import Combine

class ProfileViewModel {
    
    init(profile: ProfileResult? = nil) {
        user = CurrentValueSubject(profile)
        getUserData()
    }
    
    var user: CurrentValueSubject<ProfileResult?, Never>
    
    func getUserData() {
        NetworkService().getProfileNetworkData { [weak self] result in
            if result.count > 0 {
                self?.user.send(result[0])
            }
        }
    }
}
