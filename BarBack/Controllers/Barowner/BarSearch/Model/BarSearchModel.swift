//
//  BarSearchModel.swift
//  BarBack
//
//  Created by Rajesh gurjar on 10/10/22.
//

import Foundation

// MARK: - BarSearchModel
struct BarSearchModel: Codable {
    let success: Bool?
    let status: Int?
    let data: BarDataClass?
    let message: String?
}

// MARK: - DataClass
struct BarDataClass: Codable {
    let currentPage: Int?
    let data: [BarDatum]?
    let firstPageURL: String?
    let from, lastPage: Int?
    let lastPageURL: String?
    let links: [BarLink]?
    let nextPageURL, path: String?
    let perPage: Int?
    let prevPageURL: String?
    let to, total: Int?

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case data
        case firstPageURL = "first_page_url"
        case from
        case lastPage = "last_page"
        case lastPageURL = "last_page_url"
        case links
        case nextPageURL = "next_page_url"
        case path
        case perPage = "per_page"
        case prevPageURL = "prev_page_url"
        case to, total
    }
}

// MARK: - Datum
struct BarDatum: Codable {
    let id: Int?
    let fullname, username, email: String?
    let countryCode: String?
    let mobile: String?
    let userType: UserType?
    let profileImage, coverImage: String?
    let aboutMe: String?
    let deviceToken, deviceType: String?
    let startWorkingTime, endWorkingTime, facebookID, googleID: String?
    let appleID: String?
    let notificationPreference, visibilityPreference: Int?
    let status: Int?
    let createdAt, updatedAt: String?
    let deletedAt: String?
    let userAddress: BarUserAddress?

    enum CodingKeys: String, CodingKey {
        case id, fullname, username, email
        case countryCode = "country_code"
        case mobile
        case userType = "user_type"
        case profileImage = "profile_image"
        case coverImage = "cover_image"
        case aboutMe = "about_me"
        case deviceToken = "device_token"
        case deviceType = "device_type"
        case startWorkingTime = "start_working_time"
        case endWorkingTime = "end_working_time"
        case facebookID = "facebook_id"
        case googleID = "google_id"
        case appleID = "apple_id"
        case notificationPreference = "notification_preference"
        case visibilityPreference = "visibility_preference"
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case userAddress = "user_address"
    }
}

// MARK: - UserAddress
struct BarUserAddress: Codable {
    let id, userID: Int?
    let address1, address2, city, state: String?
    let country, zip, countryCode, latitude: String?
    let longitude: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case address1, address2, city, state, country, zip
        case countryCode = "country_code"
        case latitude, longitude
    }
}

enum UserType: String, Codable {
    case bartender = "bartender"
}

// MARK: - Link
struct BarLink: Codable {
    let url: String?
    let label: String?
    let active: Bool?
}
