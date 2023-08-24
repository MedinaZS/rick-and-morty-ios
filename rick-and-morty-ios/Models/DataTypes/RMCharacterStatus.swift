//
//  CharacterStatus.swift
//  rick-and-morty-ios
//
//  Created by Montserrat Medina on 2023-08-23.
//

import Foundation

enum RMCharacterStatus: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    /// Backticks porque unknown suele ser palabra reservada
    case `unknown` = "unknown"
    
    //To get the value in string
    var text: String {
        switch self {
        case .alive, .dead:
            return rawValue
        case .unknown:
            return "Unknown"
        }
    }
}
