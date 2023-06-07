//
//  GameControllerViewController.swift
//  textField
//
//  Created by Dmitry  Nidzelsky  on 25.04.2023.
//

import UIKit
import AVFoundation

class GameControllerViewController: UIViewController {

    var gameController = BRGameController()
    var player = Player()
    var audioPlayer: AVAudioPlayer?
    var backGRNDAudioPlayer: AVAudioPlayer?
    
    @IBOutlet weak var redBlackView: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var correctLbl: UILabel!
    
    
    @IBAction func redBttnHndler(_ sender: Any) {
        processUserAction()
    }
    
    @IBAction func blackBttnHndler(_ sender: Any) {
        processUserAction()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sound On/Off"
        scoreLabel.text = player.name + " score: \(player.countVgadav)"
        let btn = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(stopBGround))
        navigationItem.rightBarButtonItem = btn
        
        self.redBlackView.backgroundColor = .yellow
        
        
        print("player = ")
        dump(player)
        
        gameController.startGame(player: player)
        correctLbl.text = "Choose your color"
        
        playBackGround()
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func animateRB() {
        let frame = redBlackView.frame
        redBlackView.frame = CGRect(origin: frame.origin, size: CGSize(width: 250, height: 250))
        
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIView.AnimationOptions.curveLinear) { [self] in
            redBlackView.backgroundColor = self.gameController.currentCorrect == .Red ? .red : .black
            redBlackView.transform = CGAffineTransform(rotationAngle: .pi )
        } completion: { _ in
            self.redBlackView.backgroundColor = .yellow
            self.correctLbl.textColor = .blue
            self.correctLbl.text = "Choose your color"
            self.view.isUserInteractionEnabled = true
            
            self.redBlackView.frame = frame
            self.redBlackView.transform = CGAffineTransform(rotationAngle: .pi * (-2))
        }
    }
    
    func processUserAction() {
        animateRB()
        let isCorrect = gameController.makeStep(playerHod: .Red)
        playSound(isCorr: isCorrect)
        
        correctLbl.text = isCorrect ? "Correct" : "Wrong"
        correctLbl.textColor = isCorrect ? .green : .red
        scoreLabel.text = player.name + " score: \(player.countVgadav)"
        
        self.view.isUserInteractionEnabled = false
    }
    
    func playSound(isCorr: Bool) {
        guard let urlString = Bundle.main.path(forResource: isCorr ? "correct" : "Necorect", ofType: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
            audioPlayer?.play()
        } catch {
            print("Error")
        }
    }
    
    func playBackGround() {
        guard let urlString = Bundle.main.path(forResource: "backGraund", ofType: "mp3") else {return}
        
        do {
            try AVAudioSession.sharedInstance().setMode(.moviePlayback)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            backGRNDAudioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
            backGRNDAudioPlayer?.numberOfLoops = 101
            backGRNDAudioPlayer?.play()
        } catch {
            print("Error")
        }
    }
    
    @objc func stopBGround() {
        guard let player = backGRNDAudioPlayer else {return}
        
        if player.isPlaying {
            player.stop()
        } else {
            player.play()
        }
        
        let btn = UIBarButtonItem(barButtonSystemItem: (player.isPlaying == true) ? .stop : .play,
                                  target: self, action: #selector(stopBGround))
        navigationItem.rightBarButtonItem = btn
    }
   
}
