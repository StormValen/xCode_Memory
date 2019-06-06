//
//  GameScene.swift
//  SimpleMemoryGame
//
//  Created by Valentin Gutierrez on 24/04/2019.
//  Copyright © 2019 p1xelP3rfect. All rights reserved.
//

import SpriteKit
import GameplayKit

protocol GameSceneDelegate: class {
    func goToMenuScene(sender: GameScene)
}

class GameScene: SKScene, CardSpriteDelegate, ButtonDelegate {
    weak var gameSceneDelegate: GameSceneDelegate?
    
    var gameMode: GameMode?
    let gameLogic: GameLogic = GameLogic()
    
    var currentTime: TimeInterval?
    var totalPointsLabel: SKLabelNode!
    var currentTimeLabel: SKLabelNode!
    var currentComboLabel: SKLabelNode!
    var gameModeLabel: SKLabelNode!
    
    private var backButton: AppButton?
    
    var cardsSprites = [CardSprite]()
    
    override func didMove(to view: SKView) {
        
        // print("Writing on DB")
        // let userId = UUID().uuidString          // Guardar en el userDefaults.
        // FirestoreService().updateUserScore(score: 13, username: "p1xelP3rfect", userId: "D908DF3D-602D-496F-BB10-402212A21F97")
        // FirestoreService().readUserScore()
        // FirestoreService().getGameStats()
        
        let widthRatio = frame.width / 2
        // let heightRatio = widthRatio / 4.1
        
        if let gameMode = gameMode {
                gameLogic.cardsContainer = gameLogic.initCardsContainer(gameMode: gameMode)
                createCard(view: view, cards: gameLogic.cardsContainer)
                setPositionCard(view: view, xRatio: widthRatio)
                gameLogic.setMaxTime(gameModeSelected: gameMode)
                
                let wait = SKAction.wait(forDuration: 2)
                let sequence = SKAction.sequence([
                    wait,
                    SKAction.run {
                        //turn al cards
                        for i in 0..<self.cardsSprites.count{
                            self.cardsSprites[i].card?.state = CardStatus.FOLDED
                            self.cardsSprites[i].flipCard(texture: self.cardsSprites[i].texturePathBack)
                        }
                    }
                    ])
                self.run(sequence)
        }
        
        self.totalPointsLabel = SKLabelNode(text: String(gameLogic.totalPoints))
        if let totalPointsLabel = self.totalPointsLabel {
            totalPointsLabel.fontColor = SKColor(named: "Blue_1")!
            // totalPointsLabel.verticalAlignmentMode = .center
            totalPointsLabel.horizontalAlignmentMode = .left
            totalPointsLabel.fontSize = 15
            totalPointsLabel.fontName = "Futura"
            totalPointsLabel.position = CGPoint(x: (view.frame.width / 2) + 60, y: view.frame.height * 0.90 + 12)
            addChild(totalPointsLabel)
        }
        
        self.currentTimeLabel = SKLabelNode(text: "000")
        if let currentTimeLabel = self.currentTimeLabel {
            currentTimeLabel.fontColor = SKColor(named: "Blue_1")!
            // currentTimeLabel.verticalAlignmentMode = .center
            currentTimeLabel.horizontalAlignmentMode = .center
            currentTimeLabel.fontSize = 40
            currentTimeLabel.fontName = "Futura"
            currentTimeLabel.position = CGPoint(x: view.frame.width / 2, y: view.frame.height * 0.90 - 45)
            addChild(currentTimeLabel)
        }
        
        self.currentComboLabel = SKLabelNode(text: "X1")
        if let currentComboLabel = self.currentComboLabel {
            currentComboLabel.fontColor = SKColor(named: "Blue_1")!
            // currentComboLabel.verticalAlignmentMode = .center
            currentComboLabel.horizontalAlignmentMode = .right
            currentComboLabel.fontSize = 15
            currentComboLabel.fontName = "Futura"
            currentComboLabel.position = CGPoint(x: (view.frame.width / 2) - 60, y: view.frame.height * 0.90 + 12)
            addChild(currentComboLabel)
        }
        
        self.backButton = AppButton(rect: CGRect(x: 0, y: 0, width: 100, height: 40), cornerRadius: 20)
        if let backButton = backButton {
            backButton.setText(text: NSLocalizedString("MENU", comment:""))
            // backButton.fillColor = SKColor(named: "Blue_1")!
            backButton.isUserInteractionEnabled = true
            backButton.delegate = self
            backButton.position = CGPoint(x: (view.frame.width / 2) - 50, y: view.frame.height * 0.90)
            backButton.highlightColor = SKColor(named: "Blue_1")!
            backButton.strokeColor = SKColor(named: "Blue_1")!
            backButton.lineWidth = 2
            addChild(backButton)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        gameLogic.setGameTime(time: currentTime)
        gameLogic.currentTime = gameLogic.maxTime - (currentTime - gameLogic.initTime)
        
        if (gameLogic.currentTime <= 0) {
            currentTimeLabel?.text = "0"
        } else {
            currentTimeLabel?.text = String(Int(gameLogic.currentTime))
        }
        
        if (gameLogic.checkCurrentTime()) {
            print("TIME HAS ENDED")
            gameSceneDelegate?.goToMenuScene(sender: self)
        }
        
        currentComboLabel?.text = gameLogic.checkCombo()
    }
    
    func createCard(view: SKView, cards: [Card]) {
        for i in 0..<cards.count {
            let cardSprite = CardSprite(
                    size: CGSize(width: 10, height: 10),
                    texturePathFront: SKTexture(imageNamed: cards[i].texturePathFront),
                    texturePathBack: SKTexture(imageNamed: cards[i].texturePathBack))
            cardsSprites.append(cardSprite)
            cardsSprites[i].delegate = self
            cardsSprites[i].card = cards[i]
        }
    }
    
    func setPositionCard(view: SKView, xRatio: CGFloat){
        for i in 0..<cardsSprites.count {
            if gameMode == GameMode.EASY {
                if(i<4){
                    cardsSprites[i].position = CGPoint(x: view.frame.width/6, y: (xRatio/320 + CGFloat(i)) * view.frame.height / 5)
                }
                else if(i<8){
                    cardsSprites[i].position = CGPoint(x: 3 * view.frame.width/6, y: (xRatio/320 + CGFloat(i-4)) * view.frame.height / 5)
                }
                else if(i>=8){
                    cardsSprites[i].position = CGPoint(x: 5 * view.frame.width/6, y: (xRatio/320 + CGFloat(i-8)) * view.frame.height / 5)
                }
                cardsSprites[i].size = CGSize(width: xRatio/1.5, height: xRatio/1.5)
            }
            else if gameMode == GameMode.MEDIUM {
                if(i<5){
                    cardsSprites[i].position = CGPoint(x: view.frame.width/8, y: ((xRatio/320 + 0.1) + CGFloat(i)) * view.frame.height / 6.5)
                }
                else if(i<10){
                    cardsSprites[i].position = CGPoint(x: 3 * view.frame.width/8, y: ((xRatio/320 + 0.1) + CGFloat(i-5)) * view.frame.height /  6.5)
                }
                else if(i<15){
                    cardsSprites[i].position = CGPoint(x: 5 * view.frame.width/8, y: ((xRatio/320 + 0.1) + CGFloat(i-10)) * view.frame.height /  6.5)
                }
                else if(i>=15){
                    cardsSprites[i].position = CGPoint(x: 7 * view.frame.width/8, y: ((xRatio/320 + 0.1) + CGFloat(i-15)) * view.frame.height /  6.5)
                }
                cardsSprites[i].size = CGSize(width: xRatio/2.0, height: xRatio/2.0)
            }
            else if gameMode == GameMode.HARD{
                if(i<6){
                    cardsSprites[i].position = CGPoint(x: view.frame.width/10, y: ((xRatio/320 + 0.1) + CGFloat(i)) * view.frame.height / 7.8)
                }
                else if(i<12){
                    cardsSprites[i].position = CGPoint(x: 3 * view.frame.width/10, y: ((xRatio/320 + 0.1) + CGFloat(i-6)) * view.frame.height /  7.8)
                }
                else if(i<18){
                    cardsSprites[i].position = CGPoint(x: 5 * view.frame.width/10, y: ((xRatio/320 + 0.1) + CGFloat(i-12)) * view.frame.height /  7.8)
                }
                else if(i<24){
                    cardsSprites[i].position = CGPoint(x: 7 * view.frame.width/10, y: ((xRatio/320 + 0.1) + CGFloat(i-18)) * view.frame.height /  7.8)
                }
                else if(i>=24){
                    cardsSprites[i].position = CGPoint(x: 9 * view.frame.width/10, y: ((xRatio/320 + 0.1) + CGFloat(i-24)) * view.frame.height /  7.8)
                }
                cardsSprites[i].size = CGSize(width: xRatio/2.5, height: xRatio/2.5)
                
            }
            scene?.addChild(cardsSprites[i])
        }
    }
    
    func onTap(sender: AppButton) {
        gameSceneDelegate?.goToMenuScene(sender: self)
    }
    
    func onTap(sender: CardSprite) {
        guard let card = sender.card else {
            return
        }
        if (card.state != CardStatus.UNFOLDED && card.state != CardStatus.MATCHED) {
            
            gameLogic.changeCardStatus(card: card)
            
            if card.state == CardStatus.UNFOLDED {
                sender.flipCard(texture: sender.texturePathFront)
                let wait = SKAction.wait(forDuration: 1)
                
                let sequence = SKAction.sequence([wait, SKAction.run {
                    
                    let stateMatch: MatchState = self.gameLogic.checkMatch(card: card)
                    
                    if (stateMatch == MatchState.INCORRECT) {
                        if AudioController.shared.volumeOn {
                            self.run(SKAction.playSoundFileNamed("Incorrect.wav", waitForCompletion: false))
                        }
                        
                        if (card.state == CardStatus.FOLDED) {
                            sender.flipCard(texture: sender.texturePathBack)
                        }
                        
                        for i in 0..<self.cardsSprites.count {
                            if (self.cardsSprites[i].card?.id == self.gameLogic.selectedCard?.id) {
                                if (self.gameLogic.selectedCard?.state == CardStatus.UNFOLDED) {
                                    self.cardsSprites[i].flipCard(texture: sender.texturePathBack)
                                    self.cardsSprites[i].card?.state = CardStatus.FOLDED
                                }
                            }
                        }
                    } else if (stateMatch == MatchState.CORRECT) {
                        if AudioController.shared.volumeOn {
                            self.run(SKAction.playSoundFileNamed("Correct.wav", waitForCompletion: false))
                        }
                        self.totalPointsLabel?.text = String(self.gameLogic.totalPoints)
                        self.gameLogic.setComboTime()
                        for i in 0..<self.cardsSprites.count {
                            if (self.cardsSprites[i].card?.id == self.gameLogic.selectedCard?.id) {
                                if (self.gameLogic.selectedCard?.state == CardStatus.FOLDED) {
                                    self.cardsSprites[i].flipCard(texture: sender.texturePathFront)
                                }
                            }
                        }
                    }
                    
                    if (self.gameLogic.isGameEnded(cardSprites: self.cardsSprites)) {
                        print(self.gameLogic.backHighscore)
                        if (self.gameLogic.totalPoints > self.gameLogic.backHighscore) {
                            FirestoreService().writeGlobalScore(score: self.gameLogic.totalPoints)
                        }
                        self.gameSceneDelegate?.goToMenuScene(sender: self)
                    }
                }])
                self.run(sequence)
            }
        }
    }

}
