//
//  ProfileModel.swift
//  ConnectUs
//
//  Created by 김지수 on 2023/02/08.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let profileModel = try? JSONDecoder().decode(ProfileModel.self, from: jsonData)

import Foundation

// MARK: - ProfileModel
struct ProfileModel: Codable {
    let results: [ProfileResult]
    let info: ProfileInfo
}

// MARK: - Info
struct ProfileInfo: Codable {
    let seed: String
    let results, page: Int
    let version: String
}

// MARK: - Result
struct ProfileResult: Codable {
    let gender: String
    let name: ProfileName
    let location: ProfileLocation
    let email: String
    let login: ProfileLogin
    let dob, registered: ProfileDob
    let phone, cell: String
    let id: ProfileID
    let picture: Picture
    let nat: String
}

// MARK: - Dob
struct ProfileDob: Codable {
    let date: String
    let age: Int
}

// MARK: - ID
struct ProfileID: Codable {
    let name, value: String?
}

// MARK: - Location
struct ProfileLocation: Codable {
    let street: ProfileStreet
    let city, state, country: String
    let coordinates: Coordinates
    let timezone: Timezone
}

// MARK: - Coordinates
struct Coordinates: Codable {
    let latitude, longitude: String
}

// MARK: - Street
struct ProfileStreet: Codable {
    let number: Int
    let name: String
}

// MARK: - Timezone
struct Timezone: Codable {
    let offset, description: String
}

// MARK: - Login
struct ProfileLogin: Codable {
    let uuid, username, password, salt: String
    let md5, sha1, sha256: String
}

// MARK: - Name
struct ProfileName: Codable {
    let title, first, last: String
}

// MARK: - Picture
struct Picture: Codable {
    let large, medium, thumbnail: String
}
