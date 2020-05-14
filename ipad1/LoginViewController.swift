//
//  ViewController.swift
//  ipad1
//
//  Created by arrow on 5/14/20.
//  Copyright © 2020 arrow. All rights reserved.
//

import UIKit
import AVFoundation

class LoginViewController: UIViewController {

    var player:AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playBackGroundVideo()
    }
    
    // MARK:    Backgroud Video
    
    func playBackGroundVideo(){
            let path = Bundle.main.path(forResource: "asr", ofType: ".mp4")
            player = AVPlayer(url: URL(fileURLWithPath: path!))

            let playerLayer = AVPlayerLayer(player:player)
            playerLayer.frame = self.view.frame
            self.view.layer.addSublayer(playerLayer)
    //        self.view.layer.insertSublayer(playerLayer, at: 0)
            playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            
            player!.play()
            
            player!.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
    //        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.playerItemDidReachEnd(_:)), name: NSNotification.Name(rawValue : "AVPlayerItemdidPlayToEndTimeNotification"), object: player!.currentItem)
            
            NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachtoEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player!.currentItem)
            // player!.seek(to: CMTime.zero)
            // self.player?.isMuted = true
        }
        
        @objc func playerItemDidReachEnd(_ notification:Notification){
            let player: AVPlayerItem = notification.object as! AVPlayerItem
            player.seek(to: CMTime.zero)
            
        }
        
        @objc func playerItemDidReachtoEnd(){
            player!.seek(to: CMTime.zero)
        }


}

