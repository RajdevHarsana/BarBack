//
//  ProfileModel.swift
//  BarBack
//
//  Created by Rajesh gurjar on 24/09/22.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let profileModel = try? newJSONDecoder().decode(ProfileModel.self, from: jsonData)

import Foundation

// MARK: - ProfileModel
struct ProfileModel: Codable {
    let success: Bool?
    let data: ProfileDataClass?
    let message: String?
    let status: Int?
}

// MARK: - DataClass
struct ProfileDataClass: Codable {
    let id: Int?
    let fullname, username, email, countryCode: String?
    let mobile, userType: String?
    let profileImage, coverImage: String?
    let aboutMe, deviceToken, deviceType, startWorkingTime: String?
    let endWorkingTime: String?
    let facebookID, googleID, appleID: String?
    let notificationPreference: [ProfileNotificationPreference]?
    let visibilityPreference, status: Int?
    let createdAt, updatedAt: String?
    let deletedAt: String?
    let userAddress: ProfileUserAddress?
    let workingdays: [ProfileWorkingday]?
    let userSkill: [ProfileUserSkill]?
    let userLanguage: [ProfileUserLanguage]?
    let userExperience: [ProfileUserExperience]?

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
struct ProfileNotificationPreference: Codable {
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
struct ProfileUserAddress: Codable {
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
struct ProfileUserExperience: Codable {
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
struct ProfileUserLanguage: Codable {
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
struct ProfileUserSkill: Codable {
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
struct ProfileWorkingday: Codable {
    let id, userID: Int?
    let day, title: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case day,title
    }
}
