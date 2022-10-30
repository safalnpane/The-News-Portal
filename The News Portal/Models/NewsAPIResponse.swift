//
//  NewsAPIResponse.swift
//  The News Portal
//
//  Created by Safal Neupane on 25/10/2022.
//

import Foundation

// MARK: - NewsAPIResponse

struct NewsAPIResponse: Decodable {
    
    let status: String
    let totalResults: Int?
    let articles: [Article]?
    
    let code: String?
    let message: String?
}
