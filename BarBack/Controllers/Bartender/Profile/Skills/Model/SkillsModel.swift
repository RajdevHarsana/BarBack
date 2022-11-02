//
//  SkillsModel.swift
//  BarBack
//
//  Created by Rajesh gurjar on 23/09/22.
//

import Foundation

// MARK: - SkillsModel
struct SkillsModel: Codable {
    let success: Bool?
    let message: String?
    let data: [SkillsDatum]?
    let status: Int?
}

// MARK: - Datum
struct SkillsDatum: Codable {
    let id: Int?
    let title: String?
    let status: Int?
}

