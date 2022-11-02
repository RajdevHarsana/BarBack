//
//  ShiftDetiailModel.swift
//  BarBack
//
//  Created by Rajesh gurjar on 18/09/22.
//

import Foundation

// MARK: - ShiftDetiailModel
struct ShiftDetiailModel: Codable {
    let success: Bool?
    let data: ShiftDetiailDataClass?
    let message: String?
    let status: Int?
}

// MARK: - DataClass
struct ShiftDetiailDataClass: Codable {
    let id, userID: Int?
    let title: String?
    let hourlyRate: Int?
    let deadline, jobTime, dataDescription: String?
    let status: Int?
    let createdAt: String?
    let isApplied: Bool?
    let user: ShiftDetiailUser?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case title
        case hourlyRate = "hourly_rate"
        case deadline
        case jobTime = "job_time"
        case dataDescription = "description"
        case status
        case createdAt = "created_at"
        case isApplied = "is_applied"
        case user
    }
}

// MARK: - User
struct ShiftDetiailUser: Codable {
    let id: Int?
    let fullname, email: String?
    let countryCode, mobile, profileImage: String?
    let userAddress: ShiftDetiailUserAddress?
    
    enum CodingKeys: String, CodingKey {
        case id, fullname, email
        case countryCode = "country_code"
        case mobile
        case profileImage = "profile_image"
        case userAddress = "user_address"
    }
}

// MARK: - UserAddress
struct ShiftDetiailUserAddress: Codable {
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
