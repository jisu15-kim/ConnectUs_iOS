//
//  NetworkService.swift
//  ConnectUs
//
//  Created by 김지수 on 2023/01/26.
//

import Foundation
import Alamofire

class NetworkService {
    
    func getFeedsNetworkData(completion: @escaping ([PostResult]) -> Void) {
        
        let url = "\(Constant.BASE_URL)\(Constant.pathFeedsGet)"
        let header = HTTPHeader(name: "X-ACCESS-TOKEN", value: Secret.xAcessToken)
        let headers = HTTPHeaders([header])
        
        AF.request(url, headers: headers)
            .responseDecodable(of: PostModel.self, completionHandler: { response in
                switch response.result {
                case .success(let response):
                    print("====성공===")
                    completion(response.result)
                case .failure(let error):
                    print("====실패===")
                    print(error)
                }
            })
    }
    
    func getNewsNetworkData(completion: @escaping ([Article]) -> Void) {
        
        let url = "https://newsapi.org/v2/top-headlines?country=kr&apiKey=\(Secret.newsToken)"
        
        AF.request(url)
            .responseDecodable(of: NewsModel.self, completionHandler: { response in
                switch response.result {
                case .success(let response):
                    print("====성공===")
                    completion(response.articles)
                case .failure(let error):
                    print("====실패===")
                    print(error)
                }
            })
    }
}
