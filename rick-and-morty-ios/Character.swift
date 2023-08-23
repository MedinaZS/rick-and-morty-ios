//
//  Character.swift
//  rick-and-morty-ios
//
//  Created by Montserrat Medina on 2023-08-23.
//

import Foundation

struct Character: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
        case species
        case type
        case gender
    }
}

//extension Film {
//  var titleLabelText: String {
//    title
//  }
//
//  var subtitleLabelText: String {
//    "Episode \(String(id))"
//  }
//
//  var item1: (label: String, value: String) {
//    ("DIRECTOR", director)
//  }
//
//  var item2: (label: String, value: String) {
//    ("PRODUCER", producer)
//  }
//
//  var item3: (label: String, value: String) {
//    ("RELEASE DATE", releaseDate)
//  }
//
//  var listTitle: String {
//    "STARSHIPS"
//  }
//
//  var listItems: [String] {
//    starships
//  }
//}

