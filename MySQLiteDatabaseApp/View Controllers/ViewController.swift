//
//  ViewController.swift
//  MySQLiteDatabaseApp
//
//  Created by  on 2022-03-09.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var lblTable : UILabel!
    @IBOutlet var lblPicker : UILabel!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch : UITouch = touches.first!
        let touchPoint : CGPoint = touch.location(in: self.view)
        
        let tableframe : CGRect = lblTable.frame
        let pickerframe : CGRect = lblPicker.frame
        
        if tableframe.contains(touchPoint) {
            performSegue(withIdentifier: "HomeSegueToTable", sender: self)
        }
        
        if pickerframe.contains(touchPoint) {
            performSegue(withIdentifier: "HomeSegueToPicker", sender: self)
        }
        
        
        
    }
    
    @IBAction func unwindToHomeViewController(segue:UIStoryboardSegue)
    {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

