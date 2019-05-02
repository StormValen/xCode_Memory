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
}

class BottomBar: SKShapeNode {
    
    let DRAG_RECT_WIDTH : CGFloat = 80.0
    
    weak var delegate : NewGameDelegate?
    
    private var textNode = SKLabelNode()
    private var dragRect : SKShapeNode?
    
    public var state : Bool = false
    
    func setText(text: String) {
        if textNode.parent == nil {
            addChild(textNode)
            textNode.fontName = "Futura"
            textNode.fontSize = 15
            textNode.verticalAlignmentMode = .center
            textNode.position = CGPoint(x: frame.width / 2.0, y: frame.height - 40)
        }
        textNode.text = text
        
        dragRect = SKShapeNode(rect: CGRect(x: (frame.width / 2) - (DRAG_RECT_WIDTH / 2), y: frame.height - 20, width: DRAG_RECT_WIDTH, height: 5), cornerRadius: 2)
        if let dragRect = dragRect {
            addChild(dragRect)
            dragRect.fillColor = SKColor(named: "LightGrey")!
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
    
}
