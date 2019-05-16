//
//  PlayButton.swift
//  SimpleMemoryGame
//
//  Created by Valentin Gutierrez on 03/05/2019.
//  Copyright © 2019 p1xelP3rfect. All rights reserved.
//

import SpriteKit

protocol PlayButtonDelegate: class {
    func onTap(sender: PlayButton)
}


class PlayButton: SKShapeNode {
    
    weak var delegate: PlayButtonDelegate?
    private var buttonTitle = SKLabelNode()
    private var buttonSubtitle = SKLabelNode()
    
    func setText(title: String, subtitle: String, pos: CGPoint) {
        if buttonTitle.parent == nil {
            addChild(buttonTitle)
            buttonTitle.fontName = "Futura"
            buttonTitle.fontSize = 20
            buttonTitle.horizontalAlignmentMode = .left
            buttonTitle.position = CGPoint(x: pos.x + 20, y: pos.y + 40)
        }
        buttonTitle.text = title
        
        if buttonSubtitle.parent == nil {
            addChild(buttonSubtitle)
            buttonSubtitle.fontName = "Futura"
            buttonSubtitle.fontSize = 15
            buttonSubtitle.horizontalAlignmentMode = .left
            buttonSubtitle.position = CGPoint(x: pos.x + 20, y: pos.y + 20)
            buttonSubtitle.fontColor = SKColor(named: "Blue_1")!
        }
        buttonSubtitle.text = subtitle
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let delegate = delegate {
            delegate.onTap(sender: self)
        }
    }
}
