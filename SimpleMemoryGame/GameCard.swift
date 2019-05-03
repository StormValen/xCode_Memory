//
//  GameCard.swift
//  SimpleMemoryGame
//
//  Created by Valentin Gutierrez on 03/05/2019.
//  Copyright © 2019 p1xelP3rfect. All rights reserved.
//

import SpriteKit

protocol CardDelegate: class {
    func onTap(sender: GameCard)
}

class GameCard: SKShapeNode {
    
    weak var delegate: CardDelegate?
    private var cardState : Bool = false
    
    public func getCardState() -> Bool {
        return cardState
    }
    
    func flipCard() {
        cardState = !cardState
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let delegate = delegate {
            delegate.onTap(sender: self)
        }
    }
}
