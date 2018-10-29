//
//  HomeVC.swift
//  SNM
//
//  Created by Administrator on 06/09/18.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit
import MBProgressHUD


class HomeVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var menu: UIButton!
   
    //let objTrend = ApiTrending()
    var dataArray = NSMutableArray()
     var dataArray1 = NSMutableArray()
    let objApiSync = ApiTrending()
 
    var AlbumArray = ["A Spiritual Journey","A Spiritual Journey","A Spiritual Journey","A Spiritual Journey","A Spiritual Journey","A Spiritual Journey","A Spiritual Journey","A Spiritual Journey","A Spiritual Journey","A Spiritual Journey","A Spiritual Journey"]

var videoArray = ["snm","snm","snm","snm","snm","snm","snm","snm","snm","snm","snm","snm"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
//       MBProgressHUD.showAdded(to: self.view!, animated: true)
        AppDelegate.appDels.showHUD()

         self.tableView.delegate = self
        self.tableView.dataSource = self
        self.navigationController?.isNavigationBarHidden = true
         
      
        if self.revealViewController() != nil {
             self.revealViewController().rearViewRevealWidth = 300
            self.menu.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside);
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        
    }
//    func activityInicater(){
//        myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
//        // Position Activity Indicator in the center of the main view
//        myActivityIndicator.center = view.center
//        // If needed, you can prevent Acivity Indicator from hiding when stopAnimating() is called
//        myActivityIndicator.hidesWhenStopped = false
//        // Start Activity Indicator
//
//
//        myActivityIndicator.startAnimating()
//
//        view.addSubview(myActivityIndicator)
//    }
    override func viewWillAppear(_ animated: Bool) {
     self.navigationController?.isNavigationBarHidden = true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewTableViewCell", for: indexPath) as! MyTableViewTableViewCell
        cell.collectionView.tag = indexPath.section
        if indexPath.section == 3{
            if let layout = cell.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.scrollDirection = .vertical
                cell.collectionView.collectionViewLayout = layout
                cell.collectionView.isScrollEnabled = false


            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if indexPath.section == 3{
            return 400
        }
        else{
            return 120
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Trending"
        case 1:
            return "Video"
        case 2:
            return "Music"
        case 3:
            return "Generes & Bhakti"
        default:
            return ""
        }
        
    }
    
    
    
    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 2
//
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if  section == 0 {
//            return AlbumArray.count
//        }
//        else  if section == 1  {
//           return videoArray.count
//        }
//        return 0
//    }
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TrendingCollectionViewCell
//
//        if indexPath.section == 0
//        {
//         cell.layer.borderWidth = 0.5
//
//            let imgUrl = dataArray[indexPath.row]
//
//            let image_url1 = (imgUrl as AnyObject).value(forKey: "imgUrl") as! String
//            let url = URL(string: image_url1)
//            if let data = try? Data(contentsOf: url!)
//            {
//                 cell.Img.image = UIImage(data: data)
//            }
//
//            return cell
//
//        }
//
//       else if indexPath.section == 1{
//
//                cell.layer.borderWidth = 0.5
//            let imgUrl = dataArray1[indexPath.row]
//
//            let image_url1 = (imgUrl as AnyObject).value(forKey: "imgUrl") as! String
//            let url = URL(string: image_url1)
//            if let data = try? Data(contentsOf: url!)
//            {
//              cell.Img.image = UIImage(data: data)
//            }
//               // cell.songName.text = videoArray[indexPath.row]
//            return cell
//        }
//
//        return  UICollectionViewCell()
//
//
//    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if collectionView.tag == 3{
//
//            _ = dataArray1[indexPath.row]
//
//            guard let url = URL(string: "https://stackoverflow.com") else { return }
//            UIApplication.shared.open(url)
//
//        }
//
//
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TableviewTrendingViewController") as? TableviewTrendingViewController
//
//
//        self.navigationController?.pushViewController(vc!, animated: true)
//        //        selectedImage = cellImages[indexPath.row] as String
//        //        selectedLabels = cellLabels[indexPath.row] as String
//        //        self.performSegueWithIdentifer("showDetail", sender: self)
//        }
    
}



