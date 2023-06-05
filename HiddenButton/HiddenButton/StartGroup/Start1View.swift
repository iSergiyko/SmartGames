//
//  Start1View.swift
//  HiddenButton
//
//  Created by Dmitry  Nidzelsky  on 22.05.2023.
//

import Foundation
import UIKit

class Start1View: UIViewController {
  
    @IBOutlet weak var SmartGamesLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
            self.navigationController?.pushViewController(vc, animated: true)
         }
        
    }

}
