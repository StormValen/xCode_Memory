//
//  Card.swift
//  SimpleMemoryGame
//
//  Created by Valentin Gutierrez on 15/05/2019.
//  Copyright © 2019 p1xelP3rfect. All rights reserved.
//

import Foundation

enum CardStatus {
    case FOLDED
    case UNFOLDED
    case MATCHED
}

class Card {
    let id: Int
    let idPair: Int
    let texturePathFront: String
    let texturePathBack: String
    var state: CardStatus
    
    init (id: Int, idPair: Int, texturePathFront: String, texturePathBack: String, state: CardStatus) {
        self.id = id
        self.idPair = idPair
        self.texturePathFront = texturePathFront
        self.texturePathBack = texturePathBack
        self.state = state
    }
}
