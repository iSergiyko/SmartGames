//
//  Gamecontroller.swift
//  textField
//
//  Created by Dmitry  Nidzelsky  on 25.04.2023.
//

import Foundation
import CoreVideo


enum RedBlack: Int {
    case Red = 1
    case Black
    
}

class BRGameController {
    var gameMessge: String?
    var player: Player?
    var gameCounter: Int = 10
    var currentCorrect: RedBlack = .Black
    
    
    func startGame(player: Player) {
        self.player = player
        
        print("Red or black")
        gameCounter = 10
        
        // rand r/b
        let randomBool = Bool.random()
        
        currentCorrect = randomBool ? .Red : .Black
        
        let str = currentCorrect == .Red ? "Red" : "Black"
        print("currentCorrect: " + str)
    }
   
    func makeStep(playerHod: RedBlack) -> Bool {
        var isCorrect = false
        let str = currentCorrect == .Red ? "Red" : "Black"
        print("currentCorrect: " + str)
        
        if playerHod == currentCorrect {
            gameMessge = "correct"
            print(gameMessge!)
            player?.countVgadav += 1
            isCorrect = true
        } else {
            gameMessge = "wrong"
            print(gameMessge!)
        }
        
        player?.score += 1
       
        // show countdown 10...0
        gameCounter -= 1
        
        // rand new r/b
        let randomBool = Bool.random()
        currentCorrect = randomBool ? .Red : .Black
        
        // check results
        if gameCounter == 0 {
            print("perehod Hoda")
        }

        savePlayerData()
        
        return isCorrect
    }
    
    func savePlayerData() {
        guard let player = player else { return }
        
        if var names: [String] = UserDefaults.standard.object(forKey: "names") as? [String] {
            for i in 0..<names.count {
                
                var userName = names[i]
                
                let values = userName.split(separator: " ")
                
                if values.count == 3 {
                    // name
                    if values[0] == player.name {
                        // change values of userName
                        userName = "\(player.name) \(player.countVgadav) \(player.score)"
                        names[i] = userName
                        UserDefaults.standard.set(names, forKey: "names")
                        
                        print("Saving users")
                        dump(names)
                    }
                }
               
            }
        }
    }
    
}




// increment counter

// show color
//save results

//perehod hoda

//Sammary total, end game, start new game

//
