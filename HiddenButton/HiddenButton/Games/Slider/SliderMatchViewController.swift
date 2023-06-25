//
//  SliderMatchViewController.swift
//  HiddenButton
//
//  Created by Dmitry  Nidzelsky  on 23.06.2023.
//

import UIKit

class SliderMatchViewController: BasicViewController {

    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet var targetLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var roundLabel: UILabel!
    
    
    var targetValue: Int = 0
    var score = 0
    var round = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SliderMatchViewController.setUIInterfaceOrientation(.landscapeLeft)
            
        targetLabel.text = "\(targetValue)"
        newRound()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func newRound() {
        targetValue = Int.random(in: 1...100)
        targetLabel.text = "\(targetValue)"
        roundLabel.text = "\(round)"

    }

   
    
    @IBAction func showAlert(_ sender: UIButton) {
        
        var difference: Int
        var score = 0
        
        let currentValue = lroundf(slider.value)
        
        if currentValue > targetValue {
            difference = currentValue - targetValue
        } else if currentValue < targetValue {
            difference = targetValue - currentValue
        } else {
            difference = 0
        }
        
        let currentScore = 100 - difference
        
        let message = "Sliders value: \(currentValue) \nDifference: \(difference)\nPOINTS: \(currentScore)"
        
        let alertWindow = UIAlertController(title: "TARGET: \(targetValue)", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Close", style: .default)
    
        alertWindow.addAction(action)
        present(alertWindow, animated: true, completion: nil)
        
        score += currentScore
        scoreLabel.text = "\(score)"
        round += 1
        newRound()
        
    }
    
}

extension UIViewController {
    class func setUIInterfaceOrientation(_ value: UIInterfaceOrientation) {
        UIDevice.current.setValue(value.rawValue, forKey: "orientation")
    }
}
