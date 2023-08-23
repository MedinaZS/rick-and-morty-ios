//
//  ApiCharactersResponse.swift
//  rick-and-morty-ios
//
//  Created by Montserrat Medina on 2023-08-23.
//

import Foundation

struct ApiCharactersResponse: Decodable {
  let info: InfoResponse
  var all: [Character]
  
  enum CodingKeys: String, CodingKey {
    case info
    case all = "results"
  }
}

struct Character: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let image: String
  
}
