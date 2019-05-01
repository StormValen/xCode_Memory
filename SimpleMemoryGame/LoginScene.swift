//
//  LandingScene.swift
//  SimpleMemoryGame
//
//  Created by Valentin Gutierrez on 24/04/2019.
//  Copyright © 2019 p1xelP3rfect. All rights reserved.
//

import SpriteKit
import GameplayKit


protocol LoginDelegate: class {
    func goToLandingScene(sender: LoginScene)
}

class LoginScene: SKScene, ButtonDelegate {
    weak var loginDelegate: LoginDelegate?
    
    static let buttonWidth: CGFloat = 200.0
    static let buttonHeight: CGFloat = 50.0
    
    // Elements Declaration
    private var label : SKLabelNode?
    private var loginButton = AppButton(
        rect: CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight),
        cornerRadius: buttonHeight / 2)
    
    override func didMove(to view: SKView) {
        
        // Landing Title.
        self.label = SKLabelNode(text: "Memory Game - Dev")
        if let label = self.label {
            addChild(label)
            label.color = .red
            label.position = CGPoint(x: view.center.x, y: view.frame.height - 200)
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        
        // ApppButtons
        loginButton.setText(text: "LOGIN")
        loginButton.fillColor = SKColor(named: "Indigo")!
        loginButton.isUserInteractionEnabled = true
        loginButton.delegate = self
        loginButton.position = CGPoint(x: (view.frame.width / 2.0) - (LoginScene.buttonWidth / 2.0), y: view.frame.height * 0.2)
        loginButton.highlightColor = .black
        loginButton.strokeColor = .clear
        addChild(loginButton)
        
    }
    
    func onTap(sender: AppButton) {
        if (sender == loginButton) {
            loginDelegate?.goToLandingScene(sender: self)
        }
    }
}

