//
//  GameScene.swift
//  SimpleMemoryGame
//
//  Created by Valentin Gutierrez on 24/04/2019.
//  Copyright © 2019 p1xelP3rfect. All rights reserved.
//

import SpriteKit
import GameplayKit


class GameScene: SKScene, CardSpriteDelegate {
    
    var gameMode: GameMode?
    let gameLogic: GameLogic = GameLogic()
    
    var currentTime: TimeInterval?
    var totalPointsLabel: SKLabelNode!
    var currentTimeLabel: SKLabelNode!
    var gameModeLabel: SKLabelNode!
    
    var cardsSprites = [CardSprite]()
    
    override func didMove(to view: SKView) {
        
        backgroundColor = SKColor(named: "Blue_1")!
        
        //ratios
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
            totalPointsLabel.fontColor = .black
            totalPointsLabel.verticalAlignmentMode = .center
            totalPointsLabel.fontSize = 24
            totalPointsLabel.fontName = "Futura"
            totalPointsLabel.position = CGPoint(x: 6.5 * (view.frame.width / 8), y: view.frame.height * 0.91)
            addChild(totalPointsLabel)
        }
        
        
        
        self.currentTimeLabel = SKLabelNode(text: "000")
        if let currentTimeLabel = self.currentTimeLabel {
            currentTimeLabel.fontColor = .black
            currentTimeLabel.verticalAlignmentMode = .center
            currentTimeLabel.fontSize = 24
            currentTimeLabel.fontName = "Futura"
            currentTimeLabel.position = CGPoint(x: 4.5 * (view.frame.width / 8), y: view.frame.height * 0.91)
            addChild(currentTimeLabel)
        }

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
                cardsSprites[i].size = CGSize(width: xRatio/2, height: xRatio/2)
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
                        print(card.texturePathFront)
                        // AUDIO
                        
                        print(card.state)
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
                        
                        // AUDIO
                        
                        self.totalPointsLabel?.text = String(self.gameLogic.totalPoints)
                        
                        for i in 0..<self.cardsSprites.count {
                            if (self.cardsSprites[i].card?.id == self.gameLogic.selectedCard?.id) {
                                if (self.gameLogic.selectedCard?.state == CardStatus.FOLDED) {
                                    self.cardsSprites[i].flipCard(texture: sender.texturePathFront)
                                }
                            }
                        }
                    }
                    
                    if (self.gameLogic.isGameEnded(cardSprites: self.cardsSprites)) {
                        print("Game Ended!")
                    }
                }])
                self.run(sequence)
            }
        }
    }

}
