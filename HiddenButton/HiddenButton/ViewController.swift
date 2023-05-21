//
//  ViewController.swift
//  HiddenButton
//
//  Created by Dmitry  Nidzelsky  on 10.05.2023.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var buttonHndler: UIButton!
    
    let systemSoundID: SystemSoundID = 1016

    let colors: [UIColor] = [.red, .blue, .cyan, .brown, .green, .yellow, .cyan, .brown, .green, .yellow]
    let gameController = GameController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonHndler.layer.cornerRadius = 55
        buttonHndler.addAction(UIAction(handler: { _ in
            self.view.backgroundColor = .yellow
        }), for: .touchDown)
        
        buttonHndler.addAction(UIAction(handler: { _ in
            self.view.backgroundColor = .systemPurple
            AudioServicesPlaySystemSound(self.systemSoundID)
        }), for: .touchUpInside)
        
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        let rndmX = Int.random(in: 0..<Int(self.view.frame.width - buttonHndler.frame.width))
        let rndmY = Int.random(in: 0..<Int(self.view.frame.height - buttonHndler.frame.height))

        buttonHndler.frame.origin = CGPoint(x: rndmX, y: rndmY)
        self.gameController.startGame {
            let labelString = String(format: "%.2f", self.gameController.timeCounter)
            self.timerLabel.text = labelString
        }
        
        if gameController.processUserAction() {
            buttonHndler.setTitle("FINISH", for: .normal)
            buttonHndler.isUserInteractionEnabled = false
            let timerString = String(format: "%.2f", self.gameController.timeCounter)
            showUserMessage(message: "Your score is \(timerString)")
            
        } else {
            buttonHndler.setTitle("\(gameController.counterAction)", for: .normal)
            buttonHndler.backgroundColor = colors[gameController.counterAction - 1]
        }
    }
    
    
    func showUserMessage(message: String) {
        let allert = UIAlertController(title: "Game over", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { _ in
            self.buttonHndler.setTitle("START", for: .normal)
            self.buttonHndler.frame.origin = CGPoint(x: 122, y: 688)
            self.buttonHndler.isUserInteractionEnabled = true
        }
        allert.addAction(action)
        present(allert, animated: true, completion: nil)
       
    }
    
    
    
}

