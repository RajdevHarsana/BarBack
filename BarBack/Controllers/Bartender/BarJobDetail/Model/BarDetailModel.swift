//
//  BarDetailModel.swift
//  BarBack
//
//  Created by Rajesh gurjar on 20/09/22.
//

import Foundation

// MARK: - BarDetailModel
struct BarDetailModel: Codable {
    let success: Bool?
    let data: BarDetailDataClass?
    let message: String?
    let status: Int?
}

// MARK: - DataClass
struct BarDetailDataClass: Codable {
    let id: Int?
    let fullname, email: String?
    let countryCode, mobile: String?
    let profileImage, coverImage: String?
    let aboutMe, startWorkingTime, endWorkingTime: String?
    let userAddress: BarDetailUserAddress?
    let workingdays: [Workingday]?
    let jobs: [Job]?

    enum CodingKeys: String, CodingKey {
        case id, fullname, email
        case countryCode = "country_code"
        case mobile
        case profileImage = "profile_image"
        case coverImage = "cover_image"
        case aboutMe = "about_me"
        case startWorkingTime = "start_working_time"
        case endWorkingTime = "end_working_time"
        case userAddress = "user_address"
        case workingdays, jobs
    }
}

// MARK: - Job
struct Job: Codable {
    let id, userID: Int?
    let title: String?
    let hourlyRate: Int?
    let deadline, jobTime, jobDescription: String?
    let status: Int?
    let isApplied: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case title
        case hourlyRate = "hourly_rate"
        case deadline
        case jobTime = "job_time"
        case jobDescription = "description"
        case status
        case isApplied = "is_applied"
    }
}

// MARK: - UserAddress
struct BarDetailUserAddress: Codable {
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

// MARK: - Workingday
struct Workingday: Codable {
    let id, userID: Int?
    let day, title: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case day,title
    }
}
