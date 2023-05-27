//
//  CrossAndNillsViewController.swift
//  Cross&nill
//
//  Created by Dmitry  Nidzelsky  on 05.04.2023.
//

import UIKit

class CrossAndNillsViewController: UIViewController {
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn6: UIButton!
    @IBOutlet weak var btn7: UIButton!
    @IBOutlet weak var btn8: UIButton!
    @IBOutlet weak var btn9: UIButton!
    @IBOutlet weak var startNewGameBttn: UIButton!
    @IBOutlet weak var gameMessg: UILabel!
    
    var buttons: [UIButton] = []
    var isPlayerOneTurn: Bool = false
    var player1: Player = Player(name: "Red", btnTags: [], score: 0)
    var player2: Player = Player(name: "Blue", btnTags: [], score: 0)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        btn1.backgroundColor = .yellow
        gameMessg.text = "Player \(player1.name) turn "
        buttons = [btn1, btn2, btn3, btn4, btn5, btn6, btn7, btn8, btn9]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func startPressed(_ sender: Any) {
        let button: UIButton = sender as! UIButton
        button.isHidden = true
        
        // clear tags
        player1.btnTags.removeAll()
        player2.btnTags.removeAll()

        for button in buttons {
            button.setImage(UIImage(named: "fon"), for: .normal)
            button.isEnabled = true
        }
        
        gameMessg.text = ""
    }
    
    @IBAction func btnPressed(_ sender: Any) {
        let button: UIButton = sender as! UIButton

        // set button title
        if isPlayerOneTurn {
            gameMessg.text = "Player \(player1.name) turn "
            button.setImage(UIImage(named: "hrestuk"), for: .normal)
            
            print("add button tag \(button.tag ) for \(player1.name) ")
            player1.btnTags.append(button.tag)
        } else {
            gameMessg.text = "Player \(player2.name) turn "
            button.setImage(UIImage(named: "nolik"), for: .normal)
            
            print("add button tag \(button.tag ) for \(player2.name) ")
            player2.btnTags.append(button.tag)
        }
            
        if winnerChecs() {
            // TODO: stop the game
            // show winner
            var player = isPlayerOneTurn ? player1 : player2
            print("player \(player.name) WIN")
            gameMessg.text = "player \(player.name) WIN"
            
            // increment score
            player.score += 1
            
            // show "Start new game" button
            startNewGameBttn.isHidden = false
            
            // disable user interaction
            for button in buttons {
                button.isEnabled = false
            }
        } else if player1.btnTags.count + player2.btnTags.count == 9 {
            // draw
            gameMessg.text = "D R A W"
            startNewGameBttn.isHidden = false
            print("DRAW")
        } else {
            print("winnerChecs -> NO winner so far, continue game")
        }
        
        // inverse turn flag
        isPlayerOneTurn = !isPlayerOneTurn
    }
    
    func winnerChecs() -> Bool {
        let player = isPlayerOneTurn ? player1 : player2
        
        let winCombination1 = [1, 2, 3]
        let winCombination2 = [4, 5, 6]
        let winCombination3 = [7, 8, 9]
        
        let winCombination4 = [1, 4, 7]
        let winCombination5 = [2, 5, 8]
        let winCombination6 = [3, 6, 9]

        let winCombination7 = [1, 5, 9]
        let winCombination8 = [3, 5, 7]

        let combinations = [winCombination1, winCombination2, winCombination3,
                            winCombination4, winCombination5, winCombination6,
                            winCombination7, winCombination8]
        
        if player.btnTags.count < 3 {
            return false
        }
        

        // 1 2 3
        // 4 5 6
        // 7 8 9
        
        // win combinations
        for combination in combinations {
            
            var combinationCounter = 0
            
            // tags in combinations
            for tag in combination {
                // player tags
                for btntag in player.btnTags {
                    if tag == btntag {
                        combinationCounter += 1
                        continue
                    }
                }
            }
            
            // check result
            if combinationCounter == 3 {
                // player win
                return true
            }
        }
    
        return false
    }
}

