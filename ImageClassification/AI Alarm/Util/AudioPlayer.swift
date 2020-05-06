//
//  AudioPlayer.swift
//  Basic Alarm
//
//  Created by Rodrigo Giglio on 30/04/20.
//  Copyright © 2020 Rodrigo Giglio. All rights reserved.
//

import Foundation
import AVKit

class  AudioPlayer {
    
    
    //MARK: - Attributes
    var songPlayer: AVAudioPlayer?
    
    
    // MARK: - Public Functions
    func playAlarmSound() {
        
        do {
                        
            let audioFile = Bundle.main.url(forResource: "Alarm", withExtension: "mp3")!
            songPlayer = try AVAudioPlayer(contentsOf: audioFile)
            print("Did load song: \(audioFile.absoluteString)")
            
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playback)
            print("Playback OK")
            
            try AVAudioSession.sharedInstance().setActive(true)
            print("Session is Active")
            
            songPlayer?.numberOfLoops = -1
            songPlayer?.prepareToPlay()
            songPlayer?.play()
            print("Did Play song")
            
        } catch {
            
            print(error)
        }
    }
    
    func stopAlarmSound() {
        songPlayer?.stop()
    }
    
}
