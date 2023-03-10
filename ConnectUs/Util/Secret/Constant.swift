//
//  Constant.swift
//  ConnectUs
//
//  Created by 김지수 on 2023/01/26.
//

import UIKit
import Alamofire

struct Constant {

    static let defaultImage = UIImage(named: "defaultProfile")
    
    static let BASE_URL = "https://prod.chaengni.shop"

    static let pathSignUp = "/users"            //   회원가입 API
    static let pathSignAway = "/users/:userIdx"            //   회원탈퇴 API
    static let pathLogin = "/users/logIn"           //    로그인 API
    static let pathLogout = "/users/logOut"            //   로그아웃 API
    static let pathPostGet = "/posts/"              // 게시글 조회 API
    static let pathPostCreate = "/posts/"              // 게시글 작성 API
    static let pathPostPatch = "/posts?userIdx=?postIdx="     // 게시글 수정 API
    static let pathPatchLike = "/posts/likes?"
    static let pathPostDelete = "/posts?"              // 게시글 삭제 API
    static let pathFeedsGet = "/posts/feeds"             //  피드 조회 API
    static let pathProfilesEditGet = "/profiles/edit/{userIdx}"               //프로필 편집 조회 API
    static let pathProfilesEdit = "/profiles/edit/"               //프로필 편집 수정 API
    static let pathProfilesGet = "/profiles/"              // 프로필 조회 API
    static let pathPostFollow = "/follows"           //    팔로우 API
    static let pathGetFollower = "/followers"              // 팔로워 조회 API
    static let pathGetFollowing = "/followings"              // 팔로잉 조회 API
    static let getSearchData = "/searches"
    
    static let pathPostComment = "/comments?"
    static let pathLikeList = "/posts/likes?"
    
    static let pathFollowTogether = "/followers/together/"
    
    static let recommandFeed = "/posts/randFeeds"
    
    static let getPersonalInfo = "/profiles/userInfo/"
}

