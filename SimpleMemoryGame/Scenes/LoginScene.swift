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
    
    func goToSettingsScene(sender: LoginScene)
}

class LoginScene: SKScene, NewGameDelegate, ButtonDelegate {
    weak var LOGIN_DELEGATE: LoginDelegate?
    
    // private var emailFieldFrame : CGRect!
    // private var passFieldFrame : CGRect!
    
    // private var emailField : UITextField!
    // private var passField : UITextField!
    //(origin: .zero, size: CGSize(width: 200, height: 30))
    
    
    // static let buttonWidth: CGFloat = 200.0
    // static let buttonHeight: CGFloat = 50.0

    // Elements Declaration
    private var bottomBar : BottomBar?
    
    
    private var backgroundImage : SKSpriteNode?
    
    private var title : SKLabelNode?
    private var welcome : SKLabelNode?
    
    private var settingsButton : AppButton?
    private var settingsImage : SKSpriteNode?
    private var settingsIcon : SKSpriteNode?
    private var settingsBar : SKShapeNode?
    
    private var gameSelectBar : SKShapeNode?
    
    private var globalHighScoreBar : SKShapeNode?
    private var globalHighScoreName : SKLabelNode?
    private var globalHighscoreValue: SKLabelNode?
    
    
    
    
    
    
    private var globalRanking : SKLabelNode?
    private var easyRankingName : SKLabelNode?
    private var mediumRankingName : SKLabelNode?
    private var hardRankingName : SKLabelNode?
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
    
    
    // Constants
    let FONT_NAME : String = "Nunito"
    
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
        
        // super.init(texture: nil, color: .white, size: size)
        // self.texture = texturePathFront
        
        self.backgroundImage = SKSpriteNode(
            texture: SKTexture(imageNamed: "Background"),
            color: .white,
            size: CGSize(width: view.frame.width, height: view.frame.height))
        
        if let backgroundImage = backgroundImage {
            
            backgroundImage.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2)
            
            backgroundImage.isUserInteractionEnabled = false
            
            addChild(backgroundImage)
            
        }
        
        
        self.settingsImage = SKSpriteNode(
            texture: SKTexture(imageNamed: "Settings"),
            color: .white,
            size: CGSize(width: 50, height: 50))
        
        if let settingsImage = settingsImage {
            
            settingsImage.position = CGPoint(x: view.frame.width - 30, y: (view.frame.height - view.frame.height * 0.15) + 20)
            
            settingsImage.isUserInteractionEnabled = false
            
            addChild(settingsImage)
            
        }

        
        self.settingsButton = AppButton(rect: CGRect(x: 0, y: 0, width: 40, height: 40), cornerRadius: 20)
        
        if let settingsButton = settingsButton {
            
            settingsButton.setText(text: "")
            
            settingsButton.fillColor = SKColor(named: "AppBlue")!
            settingsButton.highlightColor = SKColor(named: "AppBlueHover")!
            settingsButton.strokeColor = .clear
            
            settingsButton.position = CGPoint(x: view.frame.width - 50, y: view.frame.height - view.frame.height * 0.15)
            settingsButton.lineWidth = 2
            
            settingsButton.isUserInteractionEnabled = true
            
            settingsButton.delegate = self
            
            addChild(settingsButton)
        }
        
        
        self.settingsIcon = SKSpriteNode(
            texture: SKTexture(imageNamed: "icon-options"),
            color: .white,
            size: CGSize(width: 20, height: 20))
        
        if let settingsIcon = settingsIcon {
            
            settingsIcon.position = CGPoint(x: view.frame.width - 30, y: (view.frame.height - view.frame.height * 0.15) + 20)
            
            settingsIcon.isUserInteractionEnabled = false
            
            addChild(settingsIcon)
            
        }
        
        
        settingsBar = SKShapeNode(
            rect: CGRect(
                x: frame.width - 10,
                y: 0,
                width: 20,
                height: self.frame.height))
        
        if let settingsBar = settingsBar {
            
            settingsBar.fillColor = .white
            settingsBar.strokeColor = .clear
            
            settingsBar.isUserInteractionEnabled = false
            
            addChild(settingsBar)
            
        }
        
        
        self.title = SKLabelNode(text: "</CODE LABS>")
        
        if let title = self.title {
            
            title.fontColor = .black
            title.fontName = FONT_NAME
            title.fontSize = 30
            
            title.position = CGPoint(x: 25, y: view.frame.height - view.frame.height * 0.15)
            title.horizontalAlignmentMode = .left
            
            title.isUserInteractionEnabled = false
            
            addChild(title)
        }
        
        
        self.welcome = SKLabelNode(text: "WELCOME!")
        
        if let welcome = self.welcome {
            
            welcome.fontColor = SKColor(named: "AppBlue")!
            welcome.fontName = FONT_NAME
            welcome.fontSize = 25
            
            welcome.position = CGPoint(x: 25, y: (view.frame.height - view.frame.height * 0.15) - 40)
            welcome.horizontalAlignmentMode = .left
            
            welcome.isUserInteractionEnabled = false
            
            addChild(welcome)
        }
        
        
        gameSelectBar = SKShapeNode(
            rect: CGRect(
                x: 25,
                y: (view.frame.height - view.frame.height * 0.8) + 60,
                width: self.frame.width - 50,
                height: 300), cornerRadius: 20)
        
        if let gameSelectBar = gameSelectBar {
            
            gameSelectBar.fillColor = .white
            gameSelectBar.strokeColor = .clear
            
            gameSelectBar.isUserInteractionEnabled = false
            
            addChild(gameSelectBar)
            
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
        
        
        globalHighScoreBar = SKShapeNode(
            rect: CGRect(
                x: 25,
                y: (view.frame.height - view.frame.height * 0.8) - 23,
                width: self.frame.width - 50,
                height: 65), cornerRadius: 20)
        
        if let globalHighScoreBar = globalHighScoreBar {
            
            globalHighScoreBar.fillColor = .white
            globalHighScoreBar.strokeColor = .clear
            
            globalHighScoreBar.isUserInteractionEnabled = false
            
            addChild(globalHighScoreBar)
            
        }
        
        
        self.globalHighScoreName = SKLabelNode(text: "HIGHSCORE")
        
        if let globalHighScoreName = self.globalHighScoreName {
            
            globalHighScoreName.fontColor = .black
            globalHighScoreName.fontSize = 25
            globalHighScoreName.fontName = FONT_NAME
            
            globalHighScoreName.position = CGPoint(x: 50, y: view.frame.height - view.frame.height * 0.8)
            globalHighScoreName.horizontalAlignmentMode = .left

            
            globalHighScoreName.isUserInteractionEnabled = false
            
            addChild(globalHighScoreName)
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
            
            
            
            let globalHighscoreText = self.totalGamePlayed[3]
            
            self.globalHighscoreValue = SKLabelNode(text: globalHighscoreText)
            
            if let globalHighscoreValue = self.globalHighscoreValue {
                
                
                globalHighscoreValue.fontColor = SKColor(named: "AppBlue")!
                globalHighscoreValue.fontSize = 20
                globalHighscoreValue.fontName = "Futura"
                
                globalHighscoreValue.position = CGPoint(x: view.frame.width - 50, y: view.frame.height - view.frame.height * 0.8)
                globalHighscoreValue.horizontalAlignmentMode = .right
                
                globalHighscoreValue.isUserInteractionEnabled = false
                
                self.addChild(globalHighscoreValue)
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
        LOGIN_DELEGATE?.goToGameScene(sender: self, gameMode: gameMode)
    }
    
    
    func onTap(sender: AppButton) {
        
        LOGIN_DELEGATE?.goToSettingsScene(sender: self)
        
    }
    
    
}

