//
//  GameSelectionViewController.swift
//  HiddenButton
//
//  Created by Dmitry  Nidzelsky  on 22.05.2023.
//

import Foundation
import UIKit


class GameSelectionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
  
    @IBOutlet weak var SelectGameLabel: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    
    let games = ["Hidden Button", "Cross&nill" , "Black and Red"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker.delegate = self
        self.picker.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func goButtonHndler(_ sender: UIButton) {
        let selectedRow = picker.selectedRow(inComponent: 0)
       
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var vcId: String = ""
        
        
        switch selectedRow {
        case 0:
            vcId = "HiddenButtonViewController"
        case 1:
            vcId = "CrossAndNillsViewController"
        case 2:
            print("To be implemented")
        default:
            print("Error")
        }
        
        if !vcId.isEmpty {
            let vc = storyboard.instantiateViewController(withIdentifier: vcId)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    
}

extension GameSelectionViewController {
  
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return games.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return games[row]
    }

}
