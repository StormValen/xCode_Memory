//
//  GameCard.swift
//  SimpleMemoryGame
//
//  Created by Valentin Gutierrez on 03/05/2019.
//  Copyright © 2019 p1xelP3rfect. All rights reserved.
//

import SpriteKit

protocol CardSpriteDelegate: class {
    func onTap(sender: CardSprite)
}

class CardSprite: SKSpriteNode {
    
    weak var delegate: CardSpriteDelegate?
    
    var card: Card?
    var texturePathFront: SKTexture
    var texturePathBack: SKTexture
    
    init (size: CGSize, texturePathFront: SKTexture, texturePathBack: SKTexture) {
        self.texturePathFront = texturePathFront
        self.texturePathBack = texturePathBack
        super.init(texture: nil, color: .white, size: size)
        self.texture = texturePathFront
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    
    func flipCard(texture: SKTexture) {
        let toZeroScaleAction = SKAction.scaleX(to: 0, duration: 0.1)
        let toOriginalScaleAction = SKAction.scaleX(to: 1, duration: 0.1)
        let sequence = SKAction.sequence([
                toZeroScaleAction,
                SKAction.setTexture(texture),
                toOriginalScaleAction
            ])
        self.run(sequence)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, let parent = parent {
            if frame.contains(touch.location(in: parent)) {
                if let delegate = delegate {
                    delegate.onTap(sender: self)
                }
            }
        }
    }
    
    
}
