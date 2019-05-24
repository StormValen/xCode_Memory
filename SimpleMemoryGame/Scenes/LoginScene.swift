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
    private var bottomBar : BottomBar?
    private var title : SKLabelNode?
    private var globalRanking : SKLabelNode?
    private var easyRankingName : SKLabelNode?
    private var mediumRankingName : SKLabelNode?
    private var hardRankingName : SKLabelNode?
    private var globalHighScoreName : SKLabelNode?
    private var globalHighscoreValue: SKLabelNode?
    
    private var easyHighscore: String = " - "
    private var mediumHighscore: String = " - "
    private var hardHighscore: String = " - "
    
    private var optionsButton: IconButton?
    
    
    public var totalGamePlayed: [String] = [" NO DATA ", " NO DATA ", " NO DATA ", " NO HIGHSCORES "]
    // private var loginButton = AppButton(
        // rect: CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight),
        // cornerRadius: buttonHeight / 2)
    
    // Scene Elements
    
    
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
        
        
        

        // let userId = UUID().uuidString          // Guardar en el userDefaults.
        // FirestoreService().updateUserScore(score: 13, username: "p1xelP3rfect", userId: "D908DF3D-602D-496F-BB10-402212A21F97")
        // FirestoreService().readUserScore()
        
        
        self.title = SKLabelNode(text: "</CODE LABS>")
        if let title = self.title {
            addChild(title)
            title.fontColor = SKColor(named: "Blue_1")!
            title.position = CGPoint(x: view.center.x, y: view.frame.height - view.frame.height * 0.15)
            title.fontName = "Futura"
            title.run(SKAction.fadeIn(withDuration: 2.0))
            title.isUserInteractionEnabled = false
        }
        
        self.globalRanking = SKLabelNode(text: "Total games played")
        if let globalRanking = self.globalRanking {
            addChild(globalRanking)
            globalRanking.fontColor = SKColor(named: "Blue_1")!
            globalRanking.position = CGPoint(x: view.center.x, y: view.frame.height - view.frame.height * 0.3)
            globalRanking.run(SKAction.fadeIn(withDuration: 2.0))
            globalRanking.fontSize = 25
            globalRanking.fontName = "Futura"
            globalRanking.isUserInteractionEnabled = false
        }
        
        self.globalHighScoreName = SKLabelNode(text: "Global Highscore")
        if let globalHighScoreName = self.globalHighScoreName {
            addChild(globalHighScoreName)
            globalHighScoreName.fontColor = SKColor(named: "Blue_1")!
            globalHighScoreName.position = CGPoint(x: view.center.x, y: view.frame.height - view.frame.height * 0.6)
            globalHighScoreName.run(SKAction.fadeIn(withDuration: 2.0))
            globalHighScoreName.fontSize = 25
            globalHighScoreName.fontName = "Futura"
            globalHighScoreName.isUserInteractionEnabled = false
        }
        
        self.optionsButton = IconButton(rect: CGRect(x: 0, y: 0, width: 50, height: 50), cornerRadius: 25)
        if let optionsButton = self.optionsButton {
            self.optionsButton?.setIcon(iconName: "options")
            addChild(optionsButton)
        }
        
        
        // LOADING DATA FROM FIREBASE
        FirestoreService().getGameStats() { (data) in
            self.totalGamePlayed = data
            
            let easyScore = "{ EASY } - { " + self.totalGamePlayed[0] + " games }"
            self.easyRankingName = SKLabelNode(text: easyScore)
            if let easyRankingName = self.easyRankingName {
                self.addChild(easyRankingName)
                easyRankingName.fontColor = SKColor(named: "Blue_1")!
                easyRankingName.position = CGPoint(x: view.center.x, y: view.frame.height - view.frame.height * 0.35)
                easyRankingName.run(SKAction.fadeIn(withDuration: 2.0))
                easyRankingName.fontSize = 15
                easyRankingName.fontName = "Futura"
                easyRankingName.isUserInteractionEnabled = false
            }
            
            let mediumScore = "{ MEDIUM } - { " + self.totalGamePlayed[1]  + " games }"
            self.mediumRankingName = SKLabelNode(text: mediumScore)
            if let mediumRankingName = self.mediumRankingName {
                self.addChild(mediumRankingName)
                mediumRankingName.fontColor = SKColor(named: "Blue_1")!
                mediumRankingName.position = CGPoint(x: view.center.x, y: view.frame.height - view.frame.height * 0.40)
                mediumRankingName.run(SKAction.fadeIn(withDuration: 2.0))
                mediumRankingName.fontSize = 15
                mediumRankingName.fontName = "Futura"
                mediumRankingName.isUserInteractionEnabled = false
            }
            
            let hardScore = "{ HARD } - { " + self.totalGamePlayed[2]  + " games }"
            self.hardRankingName = SKLabelNode(text: hardScore)
            if let hardRankingName = self.hardRankingName {
                self.addChild(hardRankingName)
                hardRankingName.fontColor = SKColor(named: "Blue_1")!
                hardRankingName.position = CGPoint(x: view.center.x, y: view.frame.height - view.frame.height * 0.45)
                hardRankingName.run(SKAction.fadeIn(withDuration: 2.0))
                hardRankingName.fontSize = 15
                hardRankingName.fontName = "Futura"
                hardRankingName.isUserInteractionEnabled = false
            }
            
            let globalHighscoreText = "{ SCORE } - { " + self.totalGamePlayed[3] + " points }"
            self.globalHighscoreValue = SKLabelNode(text: globalHighscoreText)
            if let globalHighscoreValue = self.globalHighscoreValue {
                self.addChild(globalHighscoreValue)
                globalHighscoreValue.fontColor = SKColor(named: "Blue_1")!
                globalHighscoreValue.position = CGPoint(x: view.center.x, y: view.frame.height - view.frame.height * 0.65)
                globalHighscoreValue.run(SKAction.fadeIn(withDuration: 2.0))
                globalHighscoreValue.fontSize = 15
                globalHighscoreValue.fontName = "Futura"
                globalHighscoreValue.isUserInteractionEnabled = false
            }
            
            self.bottomBar = BottomBar(rect: CGRect(x: 0, y: 0, width: view.frame.width, height: 400))
            if let bottomBar = self.bottomBar {
                bottomBar.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: view.frame.width, height: 400), byRoundingCorners: self.BOTTOM_BAR_CORNERS, cornerRadii: CGSize(width: 20, height: 20)).cgPath
                bottomBar.setText(text: "New Game")
                bottomBar.setButtons()
                bottomBar.fillColor = SKColor(named: "Blue_1")!
                bottomBar.isUserInteractionEnabled = true
                bottomBar.position = CGPoint(x: 0, y: -320)
                bottomBar.strokeColor = .clear
                bottomBar.delegate = self
                self.addChild(bottomBar)
            }
        }
        
        
        
        
        
        // ApppButtons
        // loginButton.setText(text: "SIGN IN")
        // loginButton.fillColor = SKColor(named: "Blue_3")!
        // loginButton.isUserInteractionEnabled = true
        // loginButton.delegate = self
        // loginButton.position = CGPoint(x: (view.frame.width / 2.0) - (LoginScene.buttonWidth / 2.0), y: view.frame.height - view.frame.height * 0.5)
        // loginButton.highlightColor = .black
        // loginButton.strokeColor = .clear
        // addChild(loginButton)
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
        FirestoreService().addGamePlayed(gameStats: totalGamePlayed, gameMode: gameMode)
        loginDelegate?.goToGameScene(sender: self, gameMode: gameMode)
    }
}

