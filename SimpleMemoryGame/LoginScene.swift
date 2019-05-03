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
    
    // private var emailFieldFrame : CGRect!
    // private var passFieldFrame : CGRect!
    
    // private var emailField : UITextField!
    // private var passField : UITextField!
    //(origin: .zero, size: CGSize(width: 200, height: 30))
    
    
    static let buttonWidth: CGFloat = 200.0
    static let buttonHeight: CGFloat = 50.0
    
    
    
    // Elements Declaration
    private var label : SKLabelNode?
    private var loginButton = AppButton(
        rect: CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight),
        cornerRadius: buttonHeight / 2)
    
    
    
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
        self.label = SKLabelNode(text: "Sign In")
        if let label = self.label {
            addChild(label)
            label.fontColor = SKColor(named: "Blue_3")!
            label.position = CGPoint(x: view.center.x, y: view.frame.height - view.frame.height * 0.15)
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        
        // ApppButtons
        loginButton.setText(text: "SIGN IN")
        loginButton.fillColor = SKColor(named: "Blue_3")!
        loginButton.isUserInteractionEnabled = true
        loginButton.delegate = self
        loginButton.position = CGPoint(x: (view.frame.width / 2.0) - (LoginScene.buttonWidth / 2.0), y: view.frame.height - view.frame.height * 0.5)
        loginButton.highlightColor = .black
        loginButton.strokeColor = .clear
        addChild(loginButton)
        
    }
    
    func onTap(sender: AppButton) {
        FirestoreService().signIn(email: "valentin.g.l@gmail.com", password: "1234aA")
        if (sender == loginButton) {
            loginDelegate?.goToLandingScene(sender: self)
        }
    }
}

