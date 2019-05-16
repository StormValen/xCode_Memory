//
//  BottomBar.swift
//  SimpleMemoryGame
//
//  Created by Valentin Gutierrez on 02/05/2019.
//  Copyright © 2019 p1xelP3rfect. All rights reserved.
//

import SpriteKit

protocol NewGameDelegate: class {
    func toggleBottomBar(sender: BottomBar)
    func startGame(sender: PlayButton, gameMode: GameMode)
}

class BottomBar: SKShapeNode, PlayButtonDelegate {
    
    let DRAG_RECT_WIDTH : CGFloat = 80.0
    let BUTTON_RECT_WIDTH : CGFloat = 80.0
    
    weak var delegate : NewGameDelegate?
    
    private var newGameText = SKLabelNode()
    private var dragRect : SKShapeNode?
    
    private var easyButton : PlayButton?
    private var mediumButton : PlayButton?
    private var hardButton : PlayButton?

    
    public var state : Bool = false
    
    
    func setButtons() {
        easyButton = PlayButton(
            rect: CGRect(
                x: frame.origin.x + 20,
                y: frame.height - 190,
                width: self.frame.width - 40,
                height: 80),
            cornerRadius: 20)
        
        if let easyButton = easyButton {
            easyButton.fillColor = SKColor(named: "Blue_2")!
            easyButton.strokeColor = .clear
            easyButton.delegate = self
            easyButton.isUserInteractionEnabled = true
            easyButton.setText(title: "Easy", subtitle: "3x4", pos: CGPoint(x: frame.origin.x + 20.0, y: frame.height - 190.0))
            addChild(easyButton)
        }
        
        mediumButton = PlayButton(
            rect: CGRect(
                x: frame.origin.x + 20,
                y: frame.height - 190 - 90,
                width: self.frame.width - 40,
                height: 80),
            cornerRadius: 20)
        
        if let mediumButton = mediumButton {
            mediumButton.fillColor = SKColor(named: "Blue_2")!
            mediumButton.strokeColor = .clear
            mediumButton.delegate = self
            mediumButton.isUserInteractionEnabled = true
            mediumButton.setText(title: "Medium", subtitle: "4x5", pos: CGPoint(x: frame.origin.x + 20.0, y: frame.height - 190.0 - 90.0))
            addChild(mediumButton)
        }
        
        hardButton = PlayButton(
            rect: CGRect(
                x: frame.origin.x + 20,
                y: frame.height - 190 - 90 - 90,
                width: self.frame.width - 40,
                height: 80),
            cornerRadius: 20)
        
        if let hardButton = hardButton {
            hardButton.fillColor = SKColor(named: "Blue_2")!
            hardButton.strokeColor = .clear
            hardButton.delegate = self
            hardButton.isUserInteractionEnabled = true
            hardButton.setText(title: "Hard", subtitle: "5x6", pos: CGPoint(x: frame.origin.x + 20.0, y: frame.height - 190.0 - 90.0 - 90.0))
            addChild(hardButton)
        }
    }
    
    func setText(text: String) {
        if newGameText.parent == nil {
            addChild(newGameText)
            newGameText.fontName = "Futura"
            newGameText.fontSize = 15
            newGameText.verticalAlignmentMode = .center
            newGameText.position = CGPoint(
                x: frame.width / 2.0,
                y: frame.height - 40)
            newGameText.fontColor = SKColor(named: "Blue_2")!
        }
        newGameText.text = text
        
        dragRect = SKShapeNode(
            rect: CGRect(
                x: (frame.width / 2) - (DRAG_RECT_WIDTH / 2),
                y: frame.height - 20,
                width: DRAG_RECT_WIDTH,
                height: 4),
            cornerRadius: 2)
        
        if let dragRect = dragRect {
            addChild(dragRect)
            dragRect.fillColor = SKColor(named: "Blue_2")!
            dragRect.strokeColor = .clear
        }
        
    }
    
    func getState() -> Bool {
        return state
    }
    
    func setState(newState: Bool) {
        state = newState
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let delegate = delegate {
            delegate.toggleBottomBar(sender: self)
        }
    }
    
    func onTap(sender: PlayButton) {
        if (sender == easyButton) {
            print("EASY MODE ********")
            if let delegate = delegate {
                delegate.startGame(sender: sender, gameMode: GameMode.EASY)
            }
        }
        if (sender == mediumButton) {
            print("MEDIUM MODE ********")
            if let delegate = delegate {
                delegate.startGame(sender: sender, gameMode: GameMode.MEDIUM)
            }
        }
        if (sender == hardButton) {
            print("HARD MODE ********")
            if let delegate = delegate {
                delegate.startGame(sender: sender, gameMode: GameMode.HARD)
            }
        }
    }
    
}
