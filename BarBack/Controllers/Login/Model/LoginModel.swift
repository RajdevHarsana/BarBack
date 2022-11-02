//
//  LoginModel.swift
//  BarBack
//
//  Created by Rajesh gurjar on 15/09/22.
//

import Foundation

// MARK: - LoginModel
struct LoginModel: Codable {
    let success: Bool?
    let expiryDate, yearExpiryDate, message: String?
    let data: LoginDataClass?
    let status: Int?

    enum CodingKeys: String, CodingKey {
        case success
        case expiryDate = "expiry_date"
        case yearExpiryDate = "year_expiry_date"
        case message, data, status
    }
}

// MARK: - DataClass
struct LoginDataClass: Codable {
    let id: Int?
    let fullname, username, email: String?
    let countryCode, mobile: String?
    let userType: String?
    let profileImage, aboutMe: String?
    let deviceToken, deviceType: String?
    let startWorkingTime, endWorkingTime: String?
    let status: Int?
    let createdAt, updatedAt: String?
    let deletedAt: String?
    let accessToken: String?

    enum CodingKeys: String, CodingKey {
        case id, fullname, username, email
        case countryCode = "country_code"
        case mobile
        case userType = "user_type"
        case profileImage = "profile_image"
        case aboutMe = "about_me"
        case deviceToken = "device_token"
        case deviceType = "device_type"
        case startWorkingTime = "start_working_time"
        case endWorkingTime = "end_working_time"
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case accessToken = "access_token"
    }
}
