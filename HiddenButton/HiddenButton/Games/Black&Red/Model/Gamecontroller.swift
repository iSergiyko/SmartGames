//
//  Gamecontroller.swift
//  textField
//
//  Created by Dmitry  Nidzelsky  on 25.04.2023.
//

import Foundation
import CoreVideo
import CoreText

enum Games: String {
    case Cross
    case HiddenButton
    case BlackAndRed
}

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
            player?.rnBScore.countVgadav += 1
            isCorrect = true
        } else {
            gameMessge = "wrong"
            print(gameMessge!)
        }
        
        player?.rnBScore.score += 1
       
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
        player.savePlayer()
    }
    
}




// increment counter

// show color
//save results

//perehod hoda

//Sammary total, end game, start new game

//
