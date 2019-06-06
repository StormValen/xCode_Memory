//
//  AudioController.swift
//  SimpleMemoryGame
//
//  Created by Valentin Gutierrez on 16/05/2019.
//  Copyright © 2019 p1xelP3rfect. All rights reserved.
//

import Foundation
import AVFoundation

class AudioController {
    let player = AVPlayer(url: Bundle.main.url(forResource: "MenúPrincipa.mp3", withExtension: nil)!)
    // let player = AVPlayer()
    private static let sharedAudioController = AudioController()
    public var volumeOn = true
    
    static var shared: AudioController {
        return sharedAudioController
    }
    
    init() {
        
    }
    
    func play() {
        player.play()
    }
    
    func pause() {
        player.pause()
    }
    
    func stop() {
        player.pause()
        player.seek(to: CMTime.zero)
    }
    
    func on() {
        player.volume = 1.0
        volumeOn = true
    }
    
    func off() {
        player.volume = 0.0
        volumeOn = false
    }
}
