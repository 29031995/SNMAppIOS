//
//  SideMenuVC.swift
//  SNM
//
//  Created by Administrator on 06/09/18.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit

class SideMenuVC: UIViewController {
    
    @IBOutlet weak var logoutBttn: UIButton!
    
var  iconImgName = ["home","megaphone","user","settings"]
    var  iconName = ["Home","Live","Profile","Setting"]
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
       
    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return iconName.count
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
//        cell.iconImg.image = UIImage(named: iconImgName[indexPath.row])
//        cell.iconName.text = iconName[indexPath.row]
//        return cell
//    }

    @IBAction func logOutAction(_ sender: UIButton) {
      //  self.navigationController?.popViewController(animated: false)
  
    }
    
}
