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
    
     // MARK: Text Field
    
    let loginContentView:UIView = {
            let view = UIView()
    //        view.backgroundColor = .green
            return view
        }()
        
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "EMAIL"
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.isSecureTextEntry = true
        textField.placeholder = "PASSWORD"
        return textField
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Login", for: .normal)
        button.addTarget(
            self,
            action: #selector(loginButtonPressed),
            for: UIControl.Event.touchUpInside)
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playBackGroundVideo()
        setupLoginContentView()
    }
    
   
    
    @objc func loginButtonPressed(sender: UIButton!) {
        print("login button pressed")
        if emailTextField.text!.isEmpty {
           print("please fill login id and password")
        } else {
            print("login id and password",emailTextField.text!,passwordTextField.text!)
        }
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

