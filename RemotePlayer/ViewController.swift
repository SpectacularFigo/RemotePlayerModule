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
    
    @IBOutlet weak var currentPlayTimeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var loadedProgressSlider: UIProgressView!
    @IBOutlet weak var currentLoadedSlider: UISlider!
    
    /** Properties*/
    var isMuted = false
    var isPaused = false
    
    //疑问: 为什么懒加载不行
    //    lazy var timer = {
    //        let timer = Timer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    //        RunLoop.current.add(timer, forMode: RunLoopMode.commonModes)
    //        return timer
    //
    //        return Timer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    //    }()
    lazy var array = {
        return [Int]()
    }()
    
    
    
    
    
    /** Override */
    override func viewDidLoad() {
        super.viewDidLoad()
        let timer = Timer(timeInterval: 1, target: self, selector: #selector(updatePlayProgress), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .commonModes)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


// MARK:- UI Events
extension ViewController{
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
    
    @IBAction func fastForward(_ sender: UIButton) {
        RemotePlayer.sharedInstance.seekWithTimeDiffer(with: 15)
    }
    
    @IBAction func rewind(_ sender: UIButton) {
        RemotePlayer.sharedInstance.seekWithTimeDiffer(with: -15)
    }
    
    @IBAction func progress(_ sender: UISlider) {
        RemotePlayer.sharedInstance.seek(with: sender.value)
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


extension ViewController{
    @objc func updatePlayProgress(){
//        print(RemotePlayer.sharedInstance.currentTimeForDisplay)
//        print(RemotePlayer.sharedInstance.totalTimeForDisplay)
        // Time Label
        currentPlayTimeLabel.text = RemotePlayer.sharedInstance.currentTimeForDisplay
        durationLabel.text = RemotePlayer.sharedInstance.totalTimeForDisplay
        
        // Loaded Progress Slider
        if let progress = RemotePlayer.sharedInstance.loadedProgress  {
              loadedProgressSlider.progress = progress
        }else{
              loadedProgressSlider.progress = 0.0
        }
        
        // Current Loaded Progress Slider
        if let currentProgress = RemotePlayer.sharedInstance.progress{
            currentLoadedSlider.value = currentProgress
        }else{
            currentLoadedSlider.value = 0.0
        }
    }
}






































