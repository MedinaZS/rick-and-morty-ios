//
//  RMCharacterTableViewCellViewModel.swift
//  rick-and-morty-ios
//
//  Created by Montserrat Medina on 2023-08-24.
//

import Foundation

final class RMCharacterTableViewCellViewModel {
    let characterName: String
    let characterStatus: RMCharacterStatus
    let characterImage: String
    let characterSpecie: String

    // MARK: - Init

    init(characterName: String, characterStatus: RMCharacterStatus, characterImage: String?, characterSpecie: String) {
        self.characterName = characterName
        self.characterStatus = characterStatus
        
        //No image photo
        let urlNoImage = "https://lppm.upnjatim.ac.id/assets/img/nophoto.png"
        self.characterImage = characterImage ?? urlNoImage
        
        self.characterSpecie = characterSpecie
    }

    public var characterStatusText: String {
        return characterStatus.text
    }
}
