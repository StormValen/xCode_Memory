//
//  LandingScene.swift
//  SimpleMemoryGame
//
//  Created by Valentin Gutierrez on 24/04/2019.
//  Copyright © 2019 p1xelP3rfect. All rights reserved.
//

import SpriteKit
import GameplayKit

class LandingScene: SKScene {
    
    static let buttonWidth: CGFloat = 200.0
    static let buttonHeight: CGFloat = 50.0
    
    // Elements Declaration
    private var label : SKLabelNode?
    private var playButton = AppButton(
        rect: CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight),
        cornerRadius: 10)
    
    override func didMove(to view: SKView) {
        
        // Landing Title.
        self.label = SKLabelNode(text: "Memory Game")
        if let label = self.label {
            addChild(label)
            label.color = .red
            label.position = CGPoint(x: view.center.x, y: view.frame.height - 200)
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        
        // ApppButtons
        playButton.setText(text: "Proceed to game")
        playButton.fillColor = SKColor(red: 0.0, green: 0.4, blue: 0.5, alpha: 1.0)
        playButton.isUserInteractionEnabled = true
        // playButton.delegate = self
        playButton.position = CGPoint(x: (view.frame.width / 2.0) - (LandingScene.buttonWidth / 2.0), y: view.frame.height * 0.2)
        playButton.highlightColor = .black
        playButton.strokeColor = .clear
        addChild(playButton)
    }
}

