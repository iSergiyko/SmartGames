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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let names = UserDefaults.standard.object(forKey: "names") as? [String] {
            
            for name in names {
                let values = name.split(separator: " ")
                
                if values.count == 3 {
                    let name = values[0]
                    let correct = values[1]
                    let total = values[2]
                    let player = Player()
                    player.name = String(name)
                    player.countVgadav = Int(correct) ?? 0
                    player.score = Int(total) ?? 0
                    
                    players.append(player)
                }
            }
        }
        
        usertableList.delegate = self
        usertableList.dataSource = self
        self.title = "Figters"
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell") as? UserTableViewCell else { return UITableViewCell() }
        
        
        let player = players[indexPath.row]
        cell.nameLbl.text = player.name
        cell.correctAttLbl.text = "\(player.countVgadav)"
        cell.totalAttLbl.text = "\(player.score)"
        
        return cell
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
            userNames.append(player.name + " \(player.countVgadav)" + " \(player.score)")
        }
        
        UserDefaults.standard.set(userNames, forKey: "names")
        usertableList.deleteRows(at: [indexPath], with: .automatic)
    }
    
}


