//
//  IconButton.swift
//  SimpleMemoryGame
//
//  Created by Valentin Gutierrez on 24/05/2019.
//  Copyright © 2019 p1xelP3rfect. All rights reserved.
//

import SpriteKit

protocol IconButtonDelegate: class {
    func onTap(sender: IconButton)
}

class IconButton: SKShapeNode {
    weak var iconButtonDelegate: IconButtonDelegate?
    private var icon: SKSpriteNode?
    
    public func setIcon(iconName: String) {
        if let icon = self.icon {
            icon.removeFromParent()
        }
        
        let icon = SKSpriteNode(imageNamed: iconName)
        icon.position = CGPoint(x: frame.width/2, y: frame.height/2)
        icon.setScale(1)
        addChild(icon)
        self.icon = icon
    }
}
