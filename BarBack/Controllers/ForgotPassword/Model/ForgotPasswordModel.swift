//
//  ForgotPasswordModel.swift
//  BarBack
//
//  Created by Rajesh gurjar on 15/09/22.
//

import Foundation

// MARK: - ForgotPasswordModel
struct ForgotPasswordModel: Codable {
    let success: Bool
    let otp: Int
    let message: String
    let status: Int
}
