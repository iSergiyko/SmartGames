//
//  SliderMatchViewController.swift
//  HiddenButton
//
//  Created by Dmitry  Nidzelsky  on 23.06.2023.
//

import UIKit

class SliderMatchViewController: BasicViewController {

    
    @IBOutlet weak var slider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SliderMatchViewController.setUIInterfaceOrientation(.landscapeLeft)
            
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }

   
    
    @IBAction func showAlert(_ sender: UIButton) {
        let alertWindow = UIAlertController(title: "Hello, world", message: "Slider value:  \(lroundf(slider.value))", preferredStyle: .alert)
        let action = UIAlertAction(title: "Close", style: .default)
    
        alertWindow.addAction(action)
        present(alertWindow, animated: true, completion: nil)
    }
    
}

extension UIViewController {
    class func setUIInterfaceOrientation(_ value: UIInterfaceOrientation) {
        UIDevice.current.setValue(value.rawValue, forKey: "orientation")
    }
}
