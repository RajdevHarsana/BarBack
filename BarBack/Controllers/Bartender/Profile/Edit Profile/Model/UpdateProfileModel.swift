//
//  UpdateProfileModel.swift
//  BarBack
//
//  Created by Rajesh gurjar on 26/09/22.
//

import Foundation

// MARK: - UpdateProfileModel
struct UpdateProfileModel: Codable {
    let success: Bool?
    let status: Int?
    let data: UpdateProfileDataClass?
    let message: String?
}

// MARK: - DataClass
struct UpdateProfileDataClass: Codable {
    let id: Int?
    let fullname, username, email, countryCode: String?
    let mobile, userType: String?
    let profileImage, coverImage: String?
    let aboutMe, deviceToken, deviceType, startWorkingTime: String?
    let endWorkingTime: String?
    let facebookID, googleID, appleID: String?
    let notificationPreference, visibilityPreference, status: Int?
    let createdAt, updatedAt: String?
    let deletedAt: String?

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
    }
}
