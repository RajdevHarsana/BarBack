//
//  BarUserProfileModel.swift
//  BarBack
//
//  Created by Rajesh gurjar on 20/10/22.
//

import Foundation

// MARK: - ProfileModel
struct BarUserProfileModel: Codable {
    let success: Bool?
    let data: BarUserProfileDataClass?
    let message: String?
    let status: Int?
}

// MARK: - DataClass
struct BarUserProfileDataClass: Codable {
    let id: Int?
    let fullname, username, email, countryCode: String?
    let mobile, userType: String?
    let profileImage, coverImage: String?
    let aboutMe, deviceToken, deviceType, startWorkingTime: String?
    let endWorkingTime: String?
    let facebookID, googleID, appleID: String?
    let notificationPreference: [BarUserProfileNotificationPreference]?
    let visibilityPreference, status: Int?
    let createdAt, updatedAt: String?
    let deletedAt: String?
    let userAddress: BarUserProfileUserAddress?
    let workingdays: [BarUserProfileWorkingday]?
    let userSkill: [BarUserProfileUserSkill]?
    let userLanguage: [BarUserProfileUserLanguage]?
    let userExperience: [BarUserProfileUserExperience]?

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
        case workingdays
        case userSkill = "user_skill"
        case userLanguage = "user_language"
        case userExperience = "user_experience"
    }
}

// MARK: - NotificationPreference
struct BarUserProfileNotificationPreference: Codable {
    let id, userID, preference: Int?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case preference
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - UserAddress
struct BarUserProfileUserAddress: Codable {
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

// MARK: - UserExperience
struct BarUserProfileUserExperience: Codable {
    let id, userID: Int?
    let title, userExperienceDescription, startDate, endDate: String?
    let years: String?
    let present: Int?
    let createdAt, updatedAt: String?
    let deletedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case title
        case userExperienceDescription = "description"
        case startDate = "start_date"
        case endDate = "end_date"
        case years, present
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
    }
}

// MARK: - UserLanguage
struct BarUserProfileUserLanguage: Codable {
    let id, userID: Int?
    let languageID, createdAt, updatedAt: String?
    let deletedAt: String?
    let language: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case languageID = "language_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case language
    }
}

// MARK: - UserSkill
struct BarUserProfileUserSkill: Codable {
    let id, userID: Int?
    let skillID, createdAt, updatedAt: String?
    let deletedAt: String?
    let skill: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case skillID = "skill_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case skill
    }
}

// MARK: - Workingday
struct BarUserProfileWorkingday: Codable {
    let id, userID: Int?
    let day, title: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case day,title
    }
}
