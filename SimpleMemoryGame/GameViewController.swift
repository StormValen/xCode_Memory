//
//  GameViewController.swift
//  SimpleMemoryGame
//
//  Created by Valentin Gutierrez on 24/04/2019.
//  Copyright © 2019 p1xelP3rfect. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Writing on DB")
        let userId = UUID().uuidString          // Guardar en el userDefaults.
        FirestoreRepository().updateUserScore(score: 11, username: "p1xelP3rfect", userId: "D908DF3D-602D-496F-BB10-402212A21F97")
        FirestoreRepository().readUserScore()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let view = self.view as? SKView {
                // Set the scale mode to scale to fit the window
                let scene = LandingScene(size: view.frame.size)
                scene.scaleMode = .aspectFill
                scene.backgroundColor = SKColor(red: 0.212, green: 0.208, blue: 0.329, alpha: 1.0)
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = false
            view.showsNodeCount = false
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
