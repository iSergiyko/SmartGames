//
//  Player.swift
//  textField
//
//  Created by Dmitry  Nidzelsky  on 25.04.2023.
//

import Foundation


class RnBScore: NSObject, NSCoding  {
    var score: Int = 0
    var countVgadav: Int = 0
    
    func encode(with coder: NSCoder) {
        coder.encode(score, forKey: "score")
        coder.encode(countVgadav, forKey: "countVgadav")
    }
    
    required init?(coder: NSCoder) {
        score = coder.decodeObject(forKey: "score") as? Int ?? 0
        countVgadav = coder.decodeObject(forKey: "countVgadav") as? Int ?? 0
    }
    
    init(score: Int, countVgadav: Int) {
        self.score = score
        self.countVgadav = countVgadav
    }
}

class HiddenScore: NSObject, NSCoding  {
    var score: Double = 0.00
    
    func encode(with coder: NSCoder) {
        coder.encode(score, forKey: "score")
    }
    
    required init?(coder: NSCoder) {
        score = coder.decodeObject(forKey: "score") as? Double ?? 0
    }
    
    init(score: Double) {
        self.score = score
    }
}

class CrossScore: NSObject, NSCoding {
    var score: Int = 0
    
    func encode(with coder: NSCoder) {
        coder.encode(score, forKey: "score")
    }
    
    required init?(coder: NSCoder) {
        score = coder.decodeObject(forKey: "score") as? Int ?? 0
    }
    
    init(score: Int) {
        self.score = score
    }
}


class Player: NSObject, NSCoding {
   
    var name: String = ""
    var rnBScore: RnBScore
    var hiddenScore: HiddenScore
    var crossScore: CrossScore

    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(rnBScore, forKey: "rnBScore")
        coder.encode(hiddenScore, forKey: "hiddenScore")
        coder.encode(crossScore, forKey: "crossScore")
    }
    
    required init?(coder: NSCoder) {
        name = coder.decodeObject(forKey: "name") as? String ?? ""
        rnBScore = RnBScore(coder: coder) ?? RnBScore(score: 0, countVgadav: 0)
        hiddenScore = HiddenScore(coder: coder) ?? HiddenScore(score: 0)
        crossScore = CrossScore(coder: coder) ?? CrossScore(score: 0)
    }
    
    init(name: String, rnBScore: RnBScore, hiddenScore: HiddenScore, crossScore: CrossScore) {
        self.name = name
        self.rnBScore = rnBScore
        self.hiddenScore = hiddenScore
        self.crossScore = crossScore
    }

    static func emptyPlayer() -> Player {
        return Player(name: "",
                      rnBScore: RnBScore(score: 0, countVgadav: 0),
                      hiddenScore: HiddenScore(score: 0),
                      crossScore: CrossScore(score: 0))
    }
    
    func savePlayer() {
        
        print("\n\n savePlayer  \n\n")
        
        if var names: [String] = UserDefaults.standard.object(forKey: "names") as? [String] {
            var isPlayerFound = false
            for i in 0..<names.count {
                let userName = names[i]
                
                // name + games info
                let values = userName.split(separator: " ")
                
                if values.count == 4 {
                    // name
                    if values[0] == self.name {
                        isPlayerFound = true
                        // change values of userName
                        
                        let playerString = self.name + " " + Games.BlackAndRed.rawValue + ":\(rnBScore.score) " +
                        Games.HiddenButton.rawValue + ":\(hiddenScore.score) " +
                        Games.Cross.rawValue + ":\(crossScore.score)"
                        
                        names[i] = playerString
                        UserDefaults.standard.set(names, forKey: "names")

                        dump(names)
                        break
                    }
                }
            }
            
            if !isPlayerFound {
                let playerString = self.name + " " + Games.BlackAndRed.rawValue + ":\(rnBScore.score) " +
                Games.HiddenButton.rawValue + ":\(hiddenScore.score) " +
                Games.Cross.rawValue + ":\(crossScore.score)"
                
                names.append(playerString)
                UserDefaults.standard.set(names, forKey: "names")

                dump(names)
            }
        } else {
            let playerString = self.name + " " + Games.BlackAndRed.rawValue + ":\(rnBScore.score) " +
            Games.HiddenButton.rawValue + ":\(hiddenScore.score) " +
            Games.Cross.rawValue + ":\(crossScore.score)"
            
            UserDefaults.standard.set([playerString], forKey: "names")
        }
    }
    
    func retrivePlayer(playerName: String) {
        
        print("\n\n retrivePlayer  \n\n")
        
        self.name = playerName
        if let names: [String] = UserDefaults.standard.object(forKey: "names") as? [String] {
            dump(names)
            // loop for names
            for i in 0..<names.count {
                let userString = names[i]
                
                // name + games info
                let values = userString.split(separator: " ")
                
                // name
                if values[0] == self.name {
                    
                    // loop for games scores
                    for value in values {
                        
                        // ex. "RNB:23"
                        let gameScores = value.split(separator: ":")

                        if gameScores.count == 2 {
                            let gameName = gameScores[0]
                            let score = gameScores[1]
                            
                            switch gameName {
                            case Games.BlackAndRed.rawValue:
                                self.rnBScore.countVgadav = Int(score) ?? 0
                                
                            case Games.Cross.rawValue:
                                self.crossScore.score = Int(score) ?? 0
                                
                            case Games.HiddenButton.rawValue:
                                self.hiddenScore.score = Double(score) ?? 0
                                
                            default:
                                break
                                
                            }
                        }
                        
                    }
                }
            }
        }
    }
    
    
    
    
    
}
