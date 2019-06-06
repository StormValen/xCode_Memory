//
//  SettingsScene.swift
//  SimpleMemoryGame
//
//  Created by Valentin Gutierrez on 04/06/2019.
//  Copyright © 2019 p1xelP3rfect. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit


protocol SettingsDelegate: class {
    
    func goToMenuScene(sender: SettingsScene)

}

class SettingsScene: SKScene, ButtonDelegate {
    
    // Constants
    let FONT_NAME : String = "Nunito"
    
    weak var SETTINGS_DELEGATE : SettingsDelegate?
    
    // Variables
    private var backButton: AppButton?
    
    private var sceneTitle : SKLabelNode?
    
    private var configSoundText : SKLabelNode?
    private var configSoundTextValue : AppButton?
    private var configGeolocalizationText : SKLabelNode?
    private var configGeolocalizationTextValue : AppButton?
    
    private var devNameHelper : SKLabelNode?
    private var devName : SKLabelNode?
    
    
    override func didMove(to view: SKView) {

        self.backgroundColor = .white
        
        
        self.backButton = AppButton(rect: CGRect(x: 0, y: 0, width: 130, height: 40), cornerRadius: 20)
        
        if let backButton = backButton {
            
            backButton.setText(text: "BACK")
            
            backButton.fillColor = SKColor(named: "AppBlue")!
            backButton.highlightColor = SKColor(named: "AppBlueHover")!
            backButton.strokeColor = .clear

            backButton.position = CGPoint(x: 25, y: view.frame.height - view.frame.height * 0.15)
            backButton.lineWidth = 2
            
            backButton.isUserInteractionEnabled = true
            
            backButton.delegate = self

            addChild(backButton)
        }
        
        
        self.sceneTitle = SKLabelNode(text: "SETTINGS")
        
        if let sceneTitle = self.sceneTitle {
            
            sceneTitle.fontColor = .black
            sceneTitle.fontName = FONT_NAME
            sceneTitle.fontSize = 30
            
            sceneTitle.position = CGPoint(x: 25, y: view.frame.height - view.frame.height * 0.25)
            sceneTitle.horizontalAlignmentMode = .left
            
            sceneTitle.isUserInteractionEnabled = false
            
            addChild(sceneTitle)
        }
        
        
        self.configSoundText = SKLabelNode(text: "Sounds")
        
        if let configSoundText = self.configSoundText {
            
            configSoundText.fontColor = .black
            configSoundText.fontName = FONT_NAME
            configSoundText.fontSize = 20
            
            configSoundText.position = CGPoint(x: 25, y: (view.frame.height - view.frame.height * 0.25) - 45)
            configSoundText.horizontalAlignmentMode = .left
            
            configSoundText.isUserInteractionEnabled = false
            
            addChild(configSoundText)
        }
        
        
        self.configSoundTextValue = AppButton(rect: CGRect(x: 0, y: 0, width: 20, height: 20), cornerRadius: 10)
        
        if let configSoundTextValue = configSoundTextValue {
            
            configSoundTextValue.setText(text: "")
            
            
            if (AudioController.shared.volumeOn) {
                
                configSoundTextValue.fillColor = SKColor(named: "AppBlue")!
                configSoundTextValue.highlightColor = .white
                configSoundTextValue.strokeColor = SKColor(named: "AppBlue")!
                
            } else if (!AudioController.shared.volumeOn) {
                
                configSoundTextValue.fillColor = .white
                configSoundTextValue.highlightColor = SKColor(named: "AppBlue")!
                configSoundTextValue.strokeColor = SKColor(named: "AppBlue")!
                
            }
            
            
            configSoundTextValue.position = CGPoint(x: view.frame.width - 45, y: (view.frame.height - view.frame.height * 0.25) - 45)
            configSoundTextValue.lineWidth = 2
            
            configSoundTextValue.isUserInteractionEnabled = true
            
            configSoundTextValue.delegate = self
            
            addChild(configSoundTextValue)
        }
        
        
        self.devNameHelper = SKLabelNode(text: "A game by:")
        
        if let devNameHelper = self.devNameHelper {
            
            devNameHelper.fontColor = .gray
            devNameHelper.fontName = FONT_NAME
            devNameHelper.fontSize = 15
            
            devNameHelper.position = CGPoint(x: view.center.x, y: 60)
            
            devNameHelper.isUserInteractionEnabled = false
            
            addChild(devNameHelper)
        }
        
        
        self.devName = SKLabelNode(text: "VALENTIN GUTIERREZ")
        
        if let devName = self.devName {
            
            devName.fontColor = .black
            devName.fontName = FONT_NAME
            devName.fontSize = 20
            
            devName.position = CGPoint(x: view.center.x, y: 30)
            
            devName.isUserInteractionEnabled = false
            
            addChild(devName)
        }
        
        
    }
    
    
    func onTap(sender: AppButton) {
        
        if (sender === self.configSoundTextValue) {
            
            if (AudioController.shared.volumeOn) {
                
                self.configSoundTextValue?.fillColor = .white
                self.configSoundTextValue?.strokeColor = SKColor(named: "AppBlue")!
                
                AudioController.shared.off()
                
            } else if (!AudioController.shared.volumeOn) {
                
                self.configSoundTextValue?.fillColor = SKColor(named: "AppBlue")!
                self.configSoundTextValue?.strokeColor = SKColor(named: "AppBlue")!
                
                AudioController.shared.on()
                
            }
            
        }
        
        if (sender === self.backButton) {
            
                SETTINGS_DELEGATE?.goToMenuScene(sender: self)
            
        }
        
        
    }
    
    
}
