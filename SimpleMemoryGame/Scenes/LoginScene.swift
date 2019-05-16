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
    func goToGameScene(sender: LoginScene, gameMode: GameMode)
}

class LoginScene: SKScene, NewGameDelegate {
    weak var loginDelegate: LoginDelegate?
    
    // private var emailFieldFrame : CGRect!
    // private var passFieldFrame : CGRect!
    
    // private var emailField : UITextField!
    // private var passField : UITextField!
    //(origin: .zero, size: CGSize(width: 200, height: 30))
    
    
    // static let buttonWidth: CGFloat = 200.0
    // static let buttonHeight: CGFloat = 50.0
    
    
    
    // Elements Declaration
    // private var label : SKLabelNode?
    // private var loginButton = AppButton(
        // rect: CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight),
        // cornerRadius: buttonHeight / 2)
    
    // Scene Elements
    private var bottomBar : BottomBar?
    
    // Variables
    let BOTTOM_BAR_HEIGHT_PERCENTAGE: CGFloat = 0.7
    let BOTTOM_BAR_CORNERS : UIRectCorner = [UIRectCorner.bottomLeft,UIRectCorner.bottomRight]
    
    override func didMove(to view: SKView) {
        
        // self.emailFieldFrame = CGRect(x: view.center.x - 100, y: view.frame.height - view.frame.height * 0.8, width: 200, height: 30)
        // self.passFieldFrame = CGRect(x: view.center.x - 100, y: view.frame.height - view.frame.height * 0.7, width: 200, height: 30)
        
        
        // emailField = UITextField(frame: emailFieldFrame)
        // emailField.backgroundColor = UIColor.clear
        // emailField.placeholder = "Email ..."
        // self.view?.addSubview(emailField)
        
        // passField = UITextField(frame: passFieldFrame)
        // passField.backgroundColor = UIColor.clear
        // passField.placeholder = "Password ..."
        // self.view?.addSubview(passField)
        
        
        
        // Landing Title.
        // self.label = SKLabelNode(text: "Sign In")
        // if let label = self.label {
            // addChild(label)
            // label.fontColor = SKColor(named: "Blue_3")!
            // label.position = CGPoint(x: view.center.x, y: view.frame.height - view.frame.height * 0.15)
            // label.run(SKAction.fadeIn(withDuration: 2.0))
        // }
        
        
        // ApppButtons
        // loginButton.setText(text: "SIGN IN")
        // loginButton.fillColor = SKColor(named: "Blue_3")!
        // loginButton.isUserInteractionEnabled = true
        // loginButton.delegate = self
        // loginButton.position = CGPoint(x: (view.frame.width / 2.0) - (LoginScene.buttonWidth / 2.0), y: view.frame.height - view.frame.height * 0.5)
        // loginButton.highlightColor = .black
        // loginButton.strokeColor = .clear
        // addChild(loginButton)
        
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
        
    }
    
    func toggleBottomBar(sender: BottomBar) {
        if let bottomBar = bottomBar {
            // if (sender == bottomBar) {
                // loginDelegate?.goToGameScene(sender: self, gameMode: GameMode.EASY)
            // }
            if (bottomBar.getState()) {
                bottomBar.setState(newState: false)
                bottomBar.run(SKAction.moveBy(x: 0, y: -320, duration: 0.2))
                
            } else {
                bottomBar.setState(newState: true)
                bottomBar.run(SKAction.moveBy(x: 0, y: 320, duration: 0.2))
                
            }
        }
    }
    
    func startGame(sender: PlayButton, gameMode: GameMode) {
        // FirestoreService().signIn(email: "valentin.g.l@gmail.com", password: "1234aA")
        loginDelegate?.goToGameScene(sender: self, gameMode: gameMode)
    }
}

