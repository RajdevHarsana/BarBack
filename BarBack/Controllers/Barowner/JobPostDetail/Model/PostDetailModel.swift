//
//  PostDetailModel.swift
//  BarBack
//
//  Created by Rajesh gurjar on 13/10/22.
//

import Foundation

// MARK: - PostDetailModel
struct PostDetailModel: Codable {
    let success: Bool?
    let data: PostDetailDataClass?
    let message: String?
    let status: Int?
}

// MARK: - DataClass
struct PostDetailDataClass: Codable {
    let id, userID: Int?
    let title: String?
    let hourlyRate: Int?
    let deadline, jobTime, dataDescription: String?
    let status: Int?
    let createdAt: String?
    let isApplied: Bool?
    let user: PostDetailUser?
    let jobRequest: [JobRequest]?
    
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
        case jobRequest = "job_request"
    }
}

// MARK: - JobRequest
struct JobRequest: Codable {
    let id, userID, jobID: Int?
    let action: String?
    let status: Int?
    let user: PostDetailUser?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case jobID = "job_id"
        case action, status, user
    }
}

// MARK: - User
struct PostDetailUser: Codable {
    let id: Int?
    let fullname, email: String?
    let countryCode: String?
    let mobile: String?
    let profileImage: String?
    let userAddress: PostDetailUserAddress?
    
    enum CodingKeys: String, CodingKey {
        case id, fullname, email
        case countryCode = "country_code"
        case mobile
        case profileImage = "profile_image"
        case userAddress = "user_address"
    }
}

// MARK: - UserAddress
struct PostDetailUserAddress: Codable {
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
