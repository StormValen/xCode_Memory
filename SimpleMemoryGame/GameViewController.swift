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

import CoreLocation

class GameViewController: UIViewController, LoginDelegate {
    
    let locationManager = CLLocationManager()
    
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
                scene.backgroundColor = SKColor(named: "Blue_3")!
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = false
            view.showsNodeCount = false
        }
        
        initLocation()
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
    
    
    func goToGameScene(sender: LoginScene, gameMode: GameMode) {
    // FirestoreService().signIn(email: "valentin.g.l@gmail.com", password: "1234aA")
        if let view = self.view as? SKView {
            let scene = GameScene(size: view.frame.size)
            scene.gameMode = gameMode
            scene.scaleMode = .aspectFill
            scene.backgroundColor = SKColor(named: "Blue_3")!
            view.presentScene(scene, transition: .crossFade(withDuration: 0.2))
        }
    }
    
    func initLocation() {
        locationManager.delegate = self
        if CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.requestLocation()
            locationManager.startUpdatingLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    
    func showAlert() {
        let dialog = UIAlertController(title: "Title", message: "Message", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok!", style: .cancel, handler: nil)
        dialog.addAction(action)
        present(dialog, animated: true, completion: nil)
    }
}


// Location Stuff
extension GameViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            print("<PERMISION> <TRUE> User has permited access to location service")
            showAlert()
            // Start requesting location updates.
            locationManager.startUpdatingLocation()
        case .denied:
            print("<PERMISION> <FALSE> User has denied access to location service")
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default:
            print("<PERMISION> <DEFAULT>")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("<ERROR> ", error.localizedDescription)
    }
    
    // Se le llama cada vez que se actualiza la posicion del usuario.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let officeLocation = CLLocation(latitude: 0, longitude: 0)
        if let lastLocation = locations.last {
            // Check if location is near location
            if lastLocation.distance(from: officeLocation) < 50 {
                // Show Welcome
                print("New Location")
            }
        }
    }
}
