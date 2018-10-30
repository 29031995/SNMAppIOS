//
//  LoginVC.swift
//  SNM
//
//  Created by Administrator on 06/09/18.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit
import GoogleSignIn
import FacebookCore
import FacebookLogin
import Alamofire
class LoginVC: UIViewController ,GIDSignInUIDelegate,GIDSignInDelegate,UITextFieldDelegate{
    
    var flag = 0
    @IBOutlet weak var facebookBttn: UIButton!
    
    @IBOutlet weak var rememberMe: UILabel!
    @IBOutlet weak var gmailBttn: UIButton!
    @IBOutlet weak var checkedBttn: UIButton!
    
    let loginManager = LoginManager()
    @IBOutlet weak var userNames: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNames.delegate = self
        password.delegate = self
       
        self.rememberMe.sizeToFit()
        self.addLineToView(view: password, position: .LINE_POSITION_BOTTOM, color: .init(displayP3Red: 17, green: 158, blue: 213, alpha: 1), width: 0.5)
        self.addLineToView(view: userNames, position: .LINE_POSITION_BOTTOM, color: .init(displayP3Red: 17, green: 158, blue: 213, alpha: 1), width: 0.5)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.userNames.text = UserDefaults.standard.string(forKey: "email")
        self.password.text = UserDefaults.standard.string(forKey: "user_Id")
        userNames.text = "nis2sewatest1"
        password.text = "niswelcome1"
    }

    @IBAction func loginActin_Btn(_ sender: UIButton)
        {
            
//            if ((userNames.text?.isEmpty)! && (password.text?.isEmpty)!) {
//                let alertController = UIAlertController(title: "Alert", message: "All fields are mandatory", preferredStyle: UIAlertControllerStyle.alert)
//
//                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
//                {
//                    (result : UIAlertAction) -> Void in
//                    print("You pressed OK")
//                }
//                alertController.addAction(okAction)
//                self.present(alertController, animated: true, completion: nil)
//            }
//
//            else if (userNames.text?.isEmpty)! {
//                let alertController = UIAlertController(title: "Alert", message: "Please Enter Username", preferredStyle: UIAlertControllerStyle.alert)
//
//                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
//                {
//                    (result : UIAlertAction) -> Void in
//                    print("You pressed OK")
//                }
//                alertController.addAction(okAction)
//                self.present(alertController, animated: true, completion: nil)
//            }
//            else if (password.text?.isEmpty)! {
//                let alertController = UIAlertController(title: "Alert", message: "Please Enter Password", preferredStyle: UIAlertControllerStyle.alert)
//
//                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
//                {
//                    (result : UIAlertAction) -> Void in
//                    print("You pressed OK")
//                }
//                alertController.addAction(okAction)
//                self.present(alertController, animated: true, completion: nil)
//            }
//            else{
//                password.resignFirstResponder()
                login()
//            }
            
        }
    
    
//func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
//{
//    if textField == userNameTxt {
//    }
//    return true
//}
    
    
    
    func login() {
        
        
                let urlString = URL(string: "https://nirankari.org/intranet/rest/post/user/login")
                let parameters:[String:String] = ["username": self.userNames.text!,"password" :self.password.text!]
        AppDelegate.appDels.showHUD()

                Alamofire.request(urlString!, method: .post,parameters: parameters, headers: nil).responseJSON { response in
                    if let JSON = response.result.value {
                        AppDelegate.appDels.removeHUD()

                        let dict : NSDictionary = JSON as! NSDictionary
                        let status = dict.value(forKey: "status") as! String
                        if status == "ok"{
                            
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let revealVc = storyboard.instantiateViewController(withIdentifier: "SWRevealViewController") as? SWRevealViewController
                            revealVc?.loadView()
                            let navViewController = revealVc?.frontViewController as! UINavigationController
                            if (navViewController.topViewController?.isKind(of: HomeVC.superclass()!))! {
                            }
                            UserDefaults.standard.set(true, forKey: "FirstLogin")
                            self.show(revealVc!, sender: self)
//                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
//
//
//                                    self.navigationController?.pushViewController(vc!, animated: true)
                        }
                        else{
                            let alert = UIAlertController(title: "Alert", message: "Email/Password is incorrect.", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                    response.result.error
        
        
                }
        
            }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func googleAction(_ sender: UIButton) {
        
        GIDSignIn.sharedInstance().delegate=self
        GIDSignIn.sharedInstance().uiDelegate=self
        GIDSignIn.sharedInstance().signIn()
    }
    @IBAction func facebookAction(_ sender: UIButton) {
        loginManager.logIn(readPermissions: [.publicProfile,.email], viewController: self) { (result) in
            switch result {
            case .failed(let error):
                print(error.localizedDescription)
                
            case .success(_,_,_):
                self.getUserInfo{ userInfo,error in
                    if let error = error{
                        print(error.localizedDescription)
                    }
                    if let userinfo = userInfo , let id = userInfo!["id"],let name = userInfo!["name"],let email = userInfo!["email"]{
                        print(name,email)
                        //Set password
                        UserDefaults.standard.set(id as? String, forKey: "user_Id")
                        self.password.text = UserDefaults.standard.string(forKey: "user_Id")
                        
                        UserDefaults.standard.set(name as? String, forKey: "username")
                        
                        // self.name.text = UserDefaults.standard.string(forKey: "username")
                        // SET USERNAME
                        UserDefaults.standard.set(email as? String, forKey: "email")
                        // self.userName.text = UserDefaults.standard.string(forKey: "username")
                        self.userNames.text = UserDefaults.standard.string(forKey: "email")
                        // self.email.text = UserDefaults.standard.string(forKey: "email")
                    }
                    
                    //  MARK:- Fetch Image From Facebook
                    // ___________________________________
                    //                    if let userinfo = userInfo , let pictureUrl = ((userInfo!["picture"] as? [String:Any])?["data"] as? [String:Any])?["url"] as? String{
                    //                        print(pictureUrl)
                    //                        UserDefaults.standard.set(pictureUrl, forKey: "IMGURL")
                    //                        let urlSTRing =  UserDefaults.standard.string(forKey: "IMGURL")
                    //
                    //                        let URL = NSURL(string: urlSTRing!)
                    //
                    //
                    //                        let imageData = NSData(contentsOf: URL as! URL)
                    //                        self.profilePik.image = UIImage(data: imageData! as Data)
                    
                }
            case .cancelled:
                print("press cancelled")
            }
            
        }
        
    }
    func getUserInfo(completion : @escaping (_:[String :Any]?,_: Error?)->Void )  {
        let request  = GraphRequest(graphPath: "me", parameters: ["fields": "id,name,email,picture"], accessToken: AccessToken.current, httpMethod: .GET, apiVersion: .defaultVersion)
        request.start { (response, result) in
            switch result{
                
            case .success(let response):
                completion(response.dictionaryValue, nil)
            case .failed(let error):
                completion(nil, error)
            }
        }
    }
    
    //MARK:-GOOGLE DELEGATE
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    // Present a view that prompts the user to sign in with Google
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            // Perform any operations on signed in user here.
            let userId = user.userID
            print(userId)
            
            // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            self.userNames.text = (user.profile.email)!
            self.password.text = user.userID!
            
            
            let Urlz = user.profile.imageURL(withDimension: 100)
            print(Urlz!)
            
            
            
            //            let imageData = NSData(contentsOf: Urlz as! URL)
            //            self.profilePik.image = UIImage(data: imageData! as Data)
            //            email.text  = (user.profile.email)!
            
            // ...
        }
    }
    
    @IBAction func rememberMeAction(_ sender: UIButton) {
        if flag == 0 {
            flag = 1
            checkedBttn.setImage(UIImage(named: "unchecked"), for: .normal)
        }
        else{
            flag = 0
            checkedBttn.setImage(UIImage(named: "combinedShape32"), for: .normal)
        }
        
    }
    
    
}
