//
//  UserListViewController.swift
//  textField
//
//  Created by Dmitry  Nidzelsky  on 29.04.2023.
//

import UIKit

class UserListViewController: UIViewController {
    @IBOutlet weak var usertableList: UITableView!
    var players = [Player]()
    
    var isExpanded: [Bool] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let names = UserDefaults.standard.object(forKey: "names") as? [String] {
            dump(names)
            for name in names {
                let values = name.split(separator: " ")
                
                
                // TODO: )))
                if values.count == 4 {
                    let name = values[0]
//                    let correct = values[1]
//                    let total = values[2]
                    
                    
                    let player = Player.emptyPlayer()
                    player.retrivePlayer(playerName: String(name))
                    players.append(player)
                    
                }
            }
            
            isExpanded = Array(repeating: false, count: players.count)
        }
        
        usertableList.delegate = self
        usertableList.dataSource = self
        self.title = "Figters"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }

    func updateCell(tag: Int) {
        
        isExpanded[tag] = !isExpanded[tag]
        
        let indexPath = IndexPath(row: tag, section: 0)
        usertableList.reloadRows(at: [indexPath], with: .fade)
    }
    
}


extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cellID = ""
        
        if isExpanded[indexPath.row] == true {
            cellID = "ExpandedCell"
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? ExpandedCell {
                cell.parentVC = self
                cell.tag = indexPath.row
                let player = players[indexPath.row]
                cell.nameLabel.text = player.name
                return cell
            }
        } else {
            cellID = "HeadCell"
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? HeadCell {
                cell.parentVC = self
                cell.tag = indexPath.row
                let player = players[indexPath.row]
                cell.nameLabel.text = player.name
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = players[indexPath.row]
        print(name)
        
        guard let ctrls = self.navigationController?.viewControllers else { return }
        for ctrl in ctrls {
            if let vc = ctrl as? LoginViewController {
                let player = players[indexPath.row]
                vc.name = player.name
                vc.player = player
            }
        }
        
        self.navigationController?.popViewController(animated: true)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alertController = UIAlertController(title: "Warning", message: "Are you sure?", preferredStyle: .alert)
            let actionOk = UIAlertAction(title: "OK", style: .destructive) { _ in
                self.removePlayerByIndexPath(indexPath: indexPath)
            }
            
            let actionCancel = UIAlertAction(title: "Cancel", style: .default) { _ in
                
            }
            
            alertController.addAction(actionOk)
            alertController.addAction(actionCancel)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func removePlayerByIndexPath(indexPath: IndexPath) {
        players.remove(at: indexPath.row)
        
        var userNames = [String]()
        for player in players {
            userNames.append(player.name + " \(player.rnBScore.countVgadav)" + " \(player.rnBScore.score)")
        }
        
        UserDefaults.standard.set(userNames, forKey: "names")
        usertableList.deleteRows(at: [indexPath], with: .automatic)
    }
    
}


