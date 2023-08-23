//
//  InfoResponse.swift
//  rick-and-morty-ios
//
//  Created by Montserrat Medina on 2023-08-23.
//

import Foundation

struct InfoResponse: Decodable {
    let count: Int
    let pages: Int
    let nextPage: String?
    let previousPage: String?
    
    enum CodingKeys: String, CodingKey {
        case count
        case pages
        case nextPage = "next"
        case previousPage = "prev"
    }
}
