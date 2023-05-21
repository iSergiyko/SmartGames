//
//  ViewController.swift
//  HiddenButton
//
//  Created by Dmitry  Nidzelsky  on 10.05.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var buttonHndler: UIButton!
    
    let colors: [UIColor] = [.red, .blue, .cyan, .brown, .green, .yellow, .cyan, .brown, .green, .yellow]
    let gameController = GameController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonHndler.layer.cornerRadius = 55
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
        } else {
            buttonHndler.setTitle("\(gameController.counterAction)", for: .normal)
            buttonHndler.backgroundColor = colors[gameController.counterAction - 1]
        }
    
        
    }
    
    
    
    
    
    
}

