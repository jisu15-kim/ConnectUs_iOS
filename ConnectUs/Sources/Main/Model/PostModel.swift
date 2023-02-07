//
//  MainModel.swift
//  ConnectUs
//
//  Created by 김지수 on 2023/01/25.
//

import Foundation

// MARK: - FeedsModel
struct PostModel: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [PostResult]
}

// MARK: - Result
struct PostResult: Codable {
    let postIdx: Int
    let content: String
    let userIdx: Int
    let userId: String
    let profileImgUrl: String?
    let postLikeCount: Int
    let commentCount: Int?
    let updateAt: String
    let postImgRes: [PostImgRes]?
}

// MARK: - PostImgRe
struct PostImgRes: Codable {
    let postImgIdx: Int?
    let postImgUrl: String?
}

// MARK: - PersonalInfoModel
struct NewsModel: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String
}
