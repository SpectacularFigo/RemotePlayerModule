//
//  ViewController.swift
//  RemotePlayer
//
//  Created by Figo Han on 2017-11-30.
//  Copyright © 2017 Figo Han. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {

//    var remotePlayer : RemotePlayer?
    var isMuted = false
    var isPaused = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func Player(_ sender: UIButton) {
        
         RemotePlayer.sharedInstance.play(with:"http://audio.xmcdn.com/group23/M04/63/C5/wKgJNFg2qdLCziiYAGQxcTOSBEw402.m4a")
        
    }
    
    @IBAction func pause(_ sender: UIButton, forEvent event: UIEvent) {
        
        RemotePlayer.sharedInstance.pause()
        isPaused = true
    }
    
    
    @IBAction func resume(_ sender: UIButton) {
        
        if isPaused {
            RemotePlayer.sharedInstance.resume()
            isPaused = false
        } else {
            return
        }
        
    }
    
    @IBAction func progress(_ sender: UISlider) {
        
        
    }
    
    @IBAction func muteButton(_ sender: UIButton) {
        
       isMuted = !isMuted
        if isMuted {
            sender.setTitle("Unmute", for: .normal )
            RemotePlayer.sharedInstance.mute = isMuted
        } else {
            sender.setTitle("Mute", for: .normal )
            RemotePlayer.sharedInstance.mute = isMuted
        }

    }
    
    @IBAction func changeVolumne(_ sender: UISlider) {
        RemotePlayer.sharedInstance.volumn = sender.value
        
    }
    
    
    
}

