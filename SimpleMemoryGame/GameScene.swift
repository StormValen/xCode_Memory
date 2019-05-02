//
//  GameScene.swift
//  SimpleMemoryGame
//
//  Created by Valentin Gutierrez on 24/04/2019.
//  Copyright © 2019 p1xelP3rfect. All rights reserved.
//

import SpriteKit
import GameplayKit


class GameScene: SKScene, NewGameDelegate {
    
    private var bottomBar : BottomBar?
    
    let BOTTOM_BAR_HEIGHT_PERCENTAGE: CGFloat = 0.7
    
    override func didMove(to view: SKView) {
        
        bottomBar = BottomBar(rect: CGRect(x: 0, y: 0, width: view.frame.width, height: 400), cornerRadius: 20)
        if let bottomBar = bottomBar {
            bottomBar.setText(text: "+ New Game")
            bottomBar.fillColor = SKColor(named: "Indigo")!
            bottomBar.isUserInteractionEnabled = true
            bottomBar.position = CGPoint(x: 0, y: -320)
            bottomBar.strokeColor = .clear
            bottomBar.delegate = self
            addChild(bottomBar)
        }
        
    }
    
    func toggleBottomBar(sender: BottomBar) {
       
        // player.run(moveAction)
        
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
    
}
