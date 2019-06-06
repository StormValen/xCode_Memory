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
    
    private var easyModeName : SKLabelNode?
    private var easyModeDesc : SKLabelNode?
    private var easyModeNum : SKLabelNode?
    private var easyPlayButton: AppButton?
    
    private var mediumModeName : SKLabelNode?
    private var mediumModeDesc : SKLabelNode?
    private var mediumModeNum : SKLabelNode?
    private var mediumPlayButton: AppButton?
    
    private var hardModeName : SKLabelNode?
    private var hardModeDesc : SKLabelNode?
    private var hardModeNum : SKLabelNode?
    private var hardPlayButton: AppButton?
    
    
    
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
        
        
        self.title = SKLabelNode(text: "!CODE LAB")
        
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
                height: 280), cornerRadius: 20)
        
        if let gameSelectBar = gameSelectBar {
            
            gameSelectBar.fillColor = .white
            gameSelectBar.strokeColor = .clear
            
            gameSelectBar.isUserInteractionEnabled = false
            
            addChild(gameSelectBar)
            
        }
        
        
        self.easyModeName = SKLabelNode(text: "EASY MODE")
        
        if let easyModeName = self.easyModeName {
            
            easyModeName.fontColor = .black
            easyModeName.fontSize = 20
            easyModeName.fontName = FONT_NAME
            
            easyModeName.position = CGPoint(x: 50, y: (view.frame.height - view.frame.height * 0.8) + 290)
            easyModeName.horizontalAlignmentMode = .left
            
            
            easyModeName.isUserInteractionEnabled = false
            
            addChild(easyModeName)
        }
        
        
        self.easyModeDesc = SKLabelNode(text: "3 X 4 Game grid")
        
        if let easyModeDesc = self.easyModeDesc {
            
            easyModeDesc.fontColor = .gray
            easyModeDesc.fontSize = 15
            easyModeDesc.fontName = FONT_NAME
            
            easyModeDesc.position = CGPoint(x: 50, y: (view.frame.height - view.frame.height * 0.8) + 270)
            easyModeDesc.horizontalAlignmentMode = .left
            
            
            easyModeDesc.isUserInteractionEnabled = false
            
            addChild(easyModeDesc)
        }
        
        
        self.easyPlayButton = AppButton(rect: CGRect(x: 0, y: 0, width: 90, height: 30), cornerRadius: 15)
        
        if let easyPlayButton = easyPlayButton {
            
            easyPlayButton.setText(text: "PLAY")
            
            easyPlayButton.fillColor = SKColor(named: "AppBlue")!
            easyPlayButton.highlightColor = SKColor(named: "AppBlueHover")!
            easyPlayButton.strokeColor = .clear
            
            easyPlayButton.position = CGPoint(x: view.frame.width - 130, y: (view.frame.height - view.frame.height * 0.8) + 280)
            easyPlayButton.lineWidth = 2
            
            easyPlayButton.isUserInteractionEnabled = true
            
            easyPlayButton.delegate = self
            
            addChild(easyPlayButton)
        }
        
        
        self.mediumModeName = SKLabelNode(text: "MEDIUM MODE")
        
        if let mediumModeName = self.mediumModeName {
            
            mediumModeName.fontColor = .black
            mediumModeName.fontSize = 20
            mediumModeName.fontName = FONT_NAME
            
            mediumModeName.position = CGPoint(x: 50, y: (view.frame.height - view.frame.height * 0.8) + 200)
            mediumModeName.horizontalAlignmentMode = .left
            
            
            mediumModeName.isUserInteractionEnabled = false
            
            addChild(mediumModeName)
        }
        
        
        self.mediumModeDesc = SKLabelNode(text: "4 X 5 Game grid")
        
        if let mediumModeDesc = self.mediumModeDesc {
            
            mediumModeDesc.fontColor = .gray
            mediumModeDesc.fontSize = 15
            mediumModeDesc.fontName = FONT_NAME
            
            mediumModeDesc.position = CGPoint(x: 50, y: (view.frame.height - view.frame.height * 0.8) + 180)
            mediumModeDesc.horizontalAlignmentMode = .left
            
            
            mediumModeDesc.isUserInteractionEnabled = false
            
            addChild(mediumModeDesc)
        }
        
        
        self.mediumPlayButton = AppButton(rect: CGRect(x: 0, y: 0, width: 90, height: 30), cornerRadius: 15)
        
        if let mediumPlayButton = mediumPlayButton {
            
            mediumPlayButton.setText(text: "PLAY")
            
            mediumPlayButton.fillColor = SKColor(named: "AppBlue")!
            mediumPlayButton.highlightColor = SKColor(named: "AppBlueHover")!
            mediumPlayButton.strokeColor = .clear
            
            mediumPlayButton.position = CGPoint(x: view.frame.width - 130, y: (view.frame.height - view.frame.height * 0.8) + 190)
            mediumPlayButton.lineWidth = 2
            
            mediumPlayButton.isUserInteractionEnabled = true
            
            mediumPlayButton.delegate = self
            
            addChild(mediumPlayButton)
        }
        
        
        self.hardModeName = SKLabelNode(text: "HARD MODE")
        
        if let hardModeName = self.hardModeName {
            
            hardModeName.fontColor = .black
            hardModeName.fontSize = 20
            hardModeName.fontName = FONT_NAME
            
            hardModeName.position = CGPoint(x: 50, y: (view.frame.height - view.frame.height * 0.8) + 110)
            hardModeName.horizontalAlignmentMode = .left
            
            
            hardModeName.isUserInteractionEnabled = false
            
            addChild(hardModeName)
        }
        
        
        self.hardModeDesc = SKLabelNode(text: "5 X 6 Game grid")
        
        if let hardModeDesc = self.hardModeDesc {
            
            hardModeDesc.fontColor = .gray
            hardModeDesc.fontSize = 15
            hardModeDesc.fontName = FONT_NAME
            
            hardModeDesc.position = CGPoint(x: 50, y: (view.frame.height - view.frame.height * 0.8) + 90)
            hardModeDesc.horizontalAlignmentMode = .left
            
            
            hardModeDesc.isUserInteractionEnabled = false
            
            addChild(hardModeDesc)
        }
        
        
        self.hardPlayButton = AppButton(rect: CGRect(x: 0, y: 0, width: 90, height: 30), cornerRadius: 15)
        
        if let hardPlayButton = hardPlayButton {
            
            hardPlayButton.setText(text: "PLAY")
            
            hardPlayButton.fillColor = SKColor(named: "AppBlue")!
            hardPlayButton.highlightColor = SKColor(named: "AppBlueHover")!
            hardPlayButton.strokeColor = .clear
            
            hardPlayButton.position = CGPoint(x: view.frame.width - 130, y: (view.frame.height - view.frame.height * 0.8) + 100)
            hardPlayButton.lineWidth = 2
            
            hardPlayButton.isUserInteractionEnabled = true
            
            hardPlayButton.delegate = self
            
            addChild(hardPlayButton)
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
            globalHighScoreName.fontSize = 20
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
                // self.addChild(easyRankingName)
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
                // self.addChild(mediumRankingName)
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
                // self.addChild(hardRankingName)
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
                // self.addChild(bottomBar)
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
        
        if (sender === self.easyPlayButton) {
            FirestoreService().addGamePlayed(gameStats: totalGamePlayed, gameMode: GameMode.EASY)
            LOGIN_DELEGATE?.goToGameScene(sender: self, gameMode: GameMode.EASY)
        }
        if (sender === self.mediumPlayButton) {
            FirestoreService().addGamePlayed(gameStats: totalGamePlayed, gameMode: GameMode.MEDIUM)
            LOGIN_DELEGATE?.goToGameScene(sender: self, gameMode: GameMode.MEDIUM)
        }
        if (sender === self.hardPlayButton) {
            FirestoreService().addGamePlayed(gameStats: totalGamePlayed, gameMode: GameMode.HARD)
            LOGIN_DELEGATE?.goToGameScene(sender: self, gameMode: GameMode.HARD)
        }
        if (sender === self.settingsButton) {
            LOGIN_DELEGATE?.goToSettingsScene(sender: self)
        }
        
        
    }
    
    
}

