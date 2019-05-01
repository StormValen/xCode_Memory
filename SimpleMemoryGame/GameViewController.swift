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

import FirebaseAuth
import FirebaseAnalytics
import GoogleMobileAds

class GameViewController: UIViewController, LoginDelegate {
    
    // var bannerView: GADBannerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Writing on DB")
        // let userId = UUID().uuidString          // Guardar en el userDefaults.
        FirestoreService().updateUserScore(score: 13, username: "p1xelP3rfect", userId: "D908DF3D-602D-496F-BB10-402212A21F97")
        FirestoreService().readUserScore()
        FirestoreService().getGameStats()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let view = self.view as? SKView {
                // Set the scale mode to scale to fit the window
                let scene = LoginScene(size: view.frame.size)
                scene.loginDelegate = self
                scene.scaleMode = .aspectFill
                scene.backgroundColor = SKColor(named: "LightGrey")!
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = false
            view.showsNodeCount = false
        }
    }
    
    func goToNextLevel(level: Int) {
        Analytics.logEvent("nextLevel", parameters: ["levelNumber": level])
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
    
    
    func goToLandingScene(sender: LoginScene) {
        FirestoreService().signIn(email: "valentin.g.l@gmail.com", password: "1234aA")
            if let view = self.view as? SKView {
                let scene = GameScene(size: view.frame.size)
                scene.scaleMode = .aspectFill
                scene.backgroundColor = SKColor(named: "LightGrey")!
                view.presentScene(scene)
            }
        }
}
