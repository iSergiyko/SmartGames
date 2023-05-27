//
//  GameController.swift
//  HiddenButton
//
//  Created by Dmitry  Nidzelsky  on 11.05.2023.
//

import Foundation

enum Levels : Int {
    case level1 = 10
    case level2 = 20

}


class HBGameController {
    var timer = Timer()
    var timeCounter = 0.0
    var counterAction = 0
    var isStartGame = false
    var gameLevelUp: Levels = .level1
    
    func updateUserInterfase() {
        
    }
    
    func startGame(timerHndlr: @escaping  () -> ()) {
        if !isStartGame {
            isStartGame = !isStartGame
            timeCounter = 0.0
            counterAction = 0
           

            timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { _ in
               self.timeCounter += 0.01
               timerHndlr()
           })
       }
    }
    
    func processUserAction() -> Bool {
        if counterAction < gameLevelUp.rawValue {
            counterAction += 1
            if counterAction == gameLevelUp.rawValue {
                timer.invalidate()
                isStartGame = !isStartGame
                return true
            }
        }
        
        return false
    }
}
