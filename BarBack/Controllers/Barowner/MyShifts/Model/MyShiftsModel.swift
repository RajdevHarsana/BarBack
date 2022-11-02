//
//  MyShiftsModel.swift
//  BarBack
//
//  Created by Rajesh gurjar on 12/10/22.
//

import Foundation

// MARK: - MyShiftsModel
struct MyShiftsModel: Codable {
    let success: Bool?
    let message: String?
    let data: MyShiftsDataClass?
    let status, minPrice, maxPrice: Int?
    
    enum CodingKeys: String, CodingKey {
        case success, message, data, status
        case minPrice = "min_price"
        case maxPrice = "max_price"
    }
}

// MARK: - DataClass
struct MyShiftsDataClass: Codable {
    let currentPage: Int?
    let data: [MyShiftsDatum]?
    let firstPageURL: String?
    let from, lastPage: Int?
    let lastPageURL: String?
    let links: [MyShiftsLink]?
    let nextPageURL: String?
    let path: String?
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
struct MyShiftsDatum: Codable {
    let id, userID: Int?
    let title: String?
    let hourlyRate: Int?
    let deadline, jobTime, datumDescription: String?
    let status: Int?
    let createdAt: String?
    let totalDays: Int?
    let postedTime: String?
    let isApplied: Bool?
    let user: MyShiftsUser?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case title
        case hourlyRate = "hourly_rate"
        case deadline
        case jobTime = "job_time"
        case datumDescription = "description"
        case status
        case createdAt = "created_at"
        case totalDays = "total_days"
        case postedTime = "posted_time"
        case isApplied = "is_applied"
        case user
    }
}

// MARK: - User
struct MyShiftsUser: Codable {
    let id: Int?
    let fullname, email: String?
    let countryCode, mobile: String?
    let profileImage: String?
    let userAddress: MyShiftsUserAddress?
    
    enum CodingKeys: String, CodingKey {
        case id, fullname, email
        case countryCode = "country_code"
        case mobile
        case profileImage = "profile_image"
        case userAddress = "user_address"
    }
}

// MARK: - UserAddress
struct MyShiftsUserAddress: Codable {
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

// MARK: - Link
struct MyShiftsLink: Codable {
    let url: String?
    let label: String?
    let active: Bool?
}