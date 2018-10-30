//
//  SNMUIViewController.swift
//  SNM
//
//  Created by Nitin Chauhan on 10/29/18.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit

class SNMUIViewController: UIViewController {
    
@IBOutlet weak var menuBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            self.revealViewController().rearViewRevealWidth = 300
            self.menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside);
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
