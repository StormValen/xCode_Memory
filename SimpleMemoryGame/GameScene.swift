//
//  GameScene.swift
//  SimpleMemoryGame
//
//  Created by Valentin Gutierrez on 24/04/2019.
//  Copyright © 2019 p1xelP3rfect. All rights reserved.
//

import SpriteKit
import GameplayKit


class GameScene: SKScene, NewGameDelegate, CardDelegate {
    
    // Scene Elements
    private var bottomBar : BottomBar?
    private var card : GameCard?
    
    // Variables
    let CARD_SIZE : CGFloat = 86
    let BOTTOM_BAR_HEIGHT_PERCENTAGE: CGFloat = 0.7
    let BOTTOM_BAR_CORNERS : UIRectCorner = [UIRectCorner.bottomLeft,UIRectCorner.bottomRight]
    
    override func didMove(to view: SKView) {
        
        bottomBar = BottomBar(rect: CGRect(x: 0, y: 0, width: view.frame.width, height: 400))
        if let bottomBar = bottomBar {
            bottomBar.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: view.frame.width, height: 400), byRoundingCorners: BOTTOM_BAR_CORNERS, cornerRadii: CGSize(width: 20, height: 20)).cgPath
            bottomBar.setText(text: "New Game")
            bottomBar.setButtons()
            bottomBar.fillColor = SKColor(named: "Blue_1")!
            bottomBar.isUserInteractionEnabled = true
            bottomBar.position = CGPoint(x: 0, y: -320)
            bottomBar.strokeColor = .clear
            bottomBar.delegate = self
            addChild(bottomBar)
        }
        
        card = GameCard(rect: CGRect(x: 10, y: view.frame.height - 100, width: CARD_SIZE, height: CARD_SIZE), cornerRadius: 20)
        if let card = card {
            card.strokeColor = .clear
            card.fillColor = SKColor(named: "Blue_2")!
            card.isUserInteractionEnabled = true
            card.delegate = self
            addChild(card)
        }
        
    }
    
    func toggleBottomBar(sender: BottomBar) {
        if let bottomBar = bottomBar {
            if (bottomBar.getState()) {
                bottomBar.setState(newState: false)
                bottomBar.run(SKAction.moveBy(x: 0, y: -320, duration: 0.2))
                
            } else {
                bottomBar.setState(newState: true)
                bottomBar.run(SKAction.moveBy(x: 0, y: 320, duration: 0.2))

            }
        }
    }
    
    func onTap(sender: GameCard) {
        if (sender == card) {
            if let card = card {
                if (card.getCardState()) {
                    card.fillColor = SKColor(named: "Blue_1")!
                } else {
                    card.fillColor = SKColor(named: "Blue_2")!
                }
                card.flipCard()
            }
        }
    }
    
}
