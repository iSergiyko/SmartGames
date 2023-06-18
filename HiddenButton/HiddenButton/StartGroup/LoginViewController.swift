//
//  ViewController.swift
//  textField
//
//  Created by Dmitry  Nidzelsky  on 20.04.2023.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var txtField: UITextField!
    
    var name = ""
    var player = Player.emptyPlayer()
    
    
    @IBAction func startButtonHandler(_ sender: Any) {
      
        guard let name = txtField.text else { return }
        if name.isEmpty {
            return
        }
        
        player.name = name
        
        if let names: [String] = UserDefaults.standard.object(forKey: "names") as? [String] {
            var isName = false
            for userName in names{
                let values = userName.split(separator: " ")
                if values.count == 3 {
                    if values[0] == name {
                        isName = true
                    }
                }
            }
            
            if !isName {
                let player = Player.emptyPlayer()
                player.name = name
                player.savePlayer()
            }
        } else {
            let player = Player.emptyPlayer()
            player.name = name
            player.savePlayer()
        }
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "Start2View") as! GameSelectionViewController
        player.retrivePlayer(playerName: player.name)
        vc.player = player
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    @IBAction func chooseBTNHndler(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "UserListViewController") as! UserListViewController
        self.navigationController?.pushViewController(vc, animated: true)
    
    }
    



    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        txtField.delegate = self
        
        
        if let names: [Any] = UserDefaults.standard.object(forKey: "names") as? [Any] {
            print(names)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        txtField.text = name
        self.navigationController?.isNavigationBarHidden = true
    }
    
}



extension UIViewController: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
   
}
