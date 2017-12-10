//
//  RemotePlayer.swift
//  RemotePlayer
//
//  Created by Figo Han on 2017-11-30.
//  Copyright © 2017 Figo Han. All rights reserved.
//

import UIKit
import AVFoundation
class RemotePlayer: NSObject {
    
    
    /** Interface */
    static let  sharedInstance = RemotePlayer()
    
    var totalTime : Double? {
        guard let durationInCMTime = self.player?.currentItem?.duration else { return nil}
        return CMTimeGetSeconds(durationInCMTime)
    }
    var currentTime : Double? {
        guard let currentTimeInCMTime = self.player?.currentTime() else { return nil }
        return CMTimeGetSeconds(currentTimeInCMTime)
    }
    var progress : Double? {
        guard let currentTime = currentTime, let totalTime = totalTime else { return nil }
        return currentTime/totalTime
    }
    var loadedProgress : Double?{
        guard let duration = totalTime else { return nil }
        let  timeRange =  player?.currentItem?.loadedTimeRanges.last as! CMTimeRange
        let loadedTime = CMTimeAdd(timeRange.start, timeRange.duration)
        let loadTimeInSecs = CMTimeGetSeconds(loadedTime)
        return loadTimeInSecs / duration
    }
    
    var mute: Bool?{
        didSet{
            player?.isMuted = mute!
        }
    }
    
    var volumn : Float?{
        didSet{
            player?.volume = volumn!
        }
    }
    
    
    
    
    
    /** Private */
    private var player : AVPlayer?   
    private var playerItem : AVPlayerItem?
    
    /** KVO */
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard keyPath == "status" else { return }
        let status = change![NSKeyValueChangeKey.newKey] as! Int
        if status == AVPlayerItemStatus.readyToPlay.rawValue {
            print("ready")
            player?.play()
        } else {
            print("not ready")
        }
        
        
    }
    
}

// MARK:- Functionalities of Player
extension RemotePlayer{
    
    func play(with urlString:String)  {
        
        let urlOptional = URL.init(string: urlString)
        guard let url = urlOptional else { return }
        playerItem = AVPlayerItem(url: url)
        playerItem?.addObserver(self, forKeyPath: "status", options: .new, context: nil)
        player = AVPlayer(playerItem: playerItem)
        player?.volume = 0.7 // Syncous with UI components
        
        
        
    }
    
    func pause(){
        
        player?.pause()
        print(playerItem?.currentTime())
        print( player?.currentTime())
    }
    
    func resume(){
        
        player?.play()
        //        guard let currentTime = player?.currentTime() else { return  }
        //        player?.seek(to: currentTime)
    }
    
    func seek(with progress: Float)  {
        
        if progress < 0 || progress > 1{
            return
        }
        
        // Duration of PlayItem
        guard let duration = player?.currentItem?.duration else { return  }
        let durationInSeconds = CMTimeGetSeconds(duration)
        
        
        // Destination Time
        let destinationTimeInSeconds = durationInSeconds * Double(progress)
        let destinationTime = CMTimeMakeWithSeconds(destinationTimeInSeconds, 1) //Why the timescal has to be 1
        
        
        player?.seek(to: destinationTime, completionHandler: { (finished) in
            
            if finished {
                print("确定加载这个时间点的音频资源")
                
            }else{
                print("取消加载这个时间点的音频资源")
            }
        })
        
    }
    
    
    func seekWithTimeDiffer(with timeDiffer: Double) {
        
        // Current time of PlayItem
        guard let currentTime = player?.currentItem?.currentTime() else { return }
        let currentTimeInSeconds = CMTimeGetSeconds(currentTime)
        
        // Detination time
        let destinationTimeInSecond = currentTimeInSeconds + timeDiffer
        let destinationTime = CMTimeMakeWithSeconds(destinationTimeInSecond, 1)
        
        
        player?.seek(to: destinationTime, completionHandler: { (finished) in
            
            if finished {
                print("确定加载这个时间点的音频资源")
                
            }else{
                print("取消加载这个时间点的音频资源")
            }
        })
        
        
    }
}














