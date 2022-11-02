//
//  LanguageModel.swift
//  BarBack
//
//  Created by Rajesh gurjar on 23/09/22.
//

import Foundation

// MARK: - LanguageModel
struct LanguageModel: Codable {
    let success: Bool?
    let message: String?
    let data: [LanguageDatum]?
    let status: Int?
}

// MARK: - Datum
struct LanguageDatum: Codable {
    let id: Int?
    let title: String?
    let status: Int?
}

