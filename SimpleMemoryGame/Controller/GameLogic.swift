//
//  GameLogic.swift
//  SimpleMemoryGame
//
//  Created by Valentin Gutierrez on 15/05/2019.
//  Copyright © 2019 p1xelP3rfect. All rights reserved.
//

import Foundation



enum GameMode: Int {
    case EASY     = 12     // 3 X 4
    case MEDIUM   = 20     // 4 X 5
    case HARD     = 30     // 5 X 6
}

enum MatchState: Int {
    case CORRECT    = 0
    case INCORRECT  = 1
    case NOT_NOW    = 2
}

class GameLogic {
    
    var totalPoints: Int
    var totalPairs: Int = 0
    var pointsIncrement = 100   // Points added per match
    
    var currentTime: TimeInterval = 0
    var maxTime: TimeInterval = 0
    var initTime: TimeInterval = 0
    var initTimeSet: Bool = false
    
    var cardsContainer = [Card]()
    var selectedCard: Card?
    var isMatchReady: Bool
    
    let textureBack = ["cardBack"]
    let arrayTexturesFront = ["pogba", "cr", "grizi", "rash", "messi", "ibra", "pique", "ramos", "bape", "rak", "ney", "aguero", "gea", "de", "salah","haz",        "kante", "linde", "lewa", "vini" ,
                         "vidal", "firm", "dyb", "cou", "chie", "icardi" ] //nombre de todas las caras
    
    
    
    init () {
        self.totalPoints = 0
        self.isMatchReady = false
    }
    
    
    func initCardsContainer(gameMode: GameMode) -> [Card] {
        cardsContainer = [Card]()
        var texturesPathFrontShuffled = arrayTexturesFront.shuffled()
        
        for i in 0..<gameMode.rawValue/2 {
            let tPathFront = texturesPathFrontShuffled[i]
            let tPathBack = textureBack.randomElement()!
            
            let card1 = Card(
                id: i,
                idPair: i,
                texturePathFront: tPathFront,
                texturePathBack: tPathBack,
                state: CardStatus.UNFOLDED)
            
            let card2 = Card(
                id: i + gameMode.rawValue,
                idPair: i,
                texturePathFront: tPathFront,
                texturePathBack: tPathBack,
                state: CardStatus.UNFOLDED)
            
            cardsContainer.append(card1)
            cardsContainer.append(card2)
        }
        
        return cardsContainer.shuffled()
    }
    
    func checkMatch(card: Card) -> MatchState {
        
        if (isMatchReady) {
            if let selectedCard = self.selectedCard {
                if (card.idPair == selectedCard.idPair) {
                    card.state = CardStatus.MATCHED
                    selectedCard.state = CardStatus.MATCHED
                    totalPoints += pointsIncrement
                    totalPairs += 1
                    isMatchReady = false
                    return MatchState.CORRECT
                } else {
                    card.state = CardStatus.FOLDED
                    selectedCard.state = CardStatus.UNFOLDED
                    isMatchReady = false
                    return MatchState.INCORRECT
                }
            } else {
                return MatchState.INCORRECT
            }
        } else {
            self.selectedCard = card
            self.selectedCard?.state = CardStatus.UNFOLDED
            isMatchReady = true
            return MatchState.NOT_NOW
        }
    }
    
    func isGameEnded(cardSprites: [CardSprite]) -> Bool {
        for i in 0..<cardSprites.count {
            if (cardSprites[i].card?.state != CardStatus.MATCHED) {
                return false
            }
        }
        return true
    }
    
    func changeCardStatus(card: Card) {
        card.state = CardStatus.UNFOLDED
    }
    
    
    func setMaxTime(gameModeSelected: GameMode) {
        switch gameModeSelected {
        case .EASY:
            self.maxTime = 100
            break;
        case .MEDIUM:
            self.maxTime = 200
            break;
        case .HARD:
            self.maxTime = 300
            break;
        }
    }
    
    func checkCurrentTime() -> Bool {
        if (currentTime <= 0) {
            currentTime = 0
            return true
        }
        return false
    }
    
    func setGameTime(time: TimeInterval) {
        if (!initTimeSet) {
            initTime = time
            initTimeSet = true
        }
    }
}