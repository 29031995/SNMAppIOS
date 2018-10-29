//
//  ProfileViewController.swift
//  SNM
//
//  Created by Administrator on 11/09/18.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var firstName: kTextFiledPlaceHolder!
    
    @IBOutlet weak var phoneNumber: kTextFiledPlaceHolder!
    @IBOutlet weak var emailID: kTextFiledPlaceHolder!
    @IBOutlet weak var lastName: kTextFiledPlaceHolder!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       adjustCurser(textfield: firstName)
       adjustCurser(textfield: lastName)
    adjustCurser(textfield: emailID)
        adjustCurser(textfield: phoneNumber)
    }

    func adjustCurser(textfield : kTextFiledPlaceHolder){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textfield.frame.height))
        textfield.leftView = paddingView
        textfield.leftViewMode = UITextFieldViewMode.always
        
    }
    
   
   

}
