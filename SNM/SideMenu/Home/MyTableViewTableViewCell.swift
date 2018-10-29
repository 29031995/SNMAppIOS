//
//  MyTableViewTableViewCell.swift
//  SNM
//
//  Created by Rajlaxmi Shekhawat on 18/10/18.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit
import AVKit
import MBProgressHUD
import AlamofireImage



class MyTableViewTableViewCell: UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,syncApi,syncvideoApi,syncItemsApi{

    
 var myActivityIndicator = UIActivityIndicatorView()
    var objTrend = videoApi()
    var dataArray1 = NSMutableArray()
    var dataArray2 = NSMutableArray()
    var maskArray = ["kids.png","camera.jpg","Voice.jpg","Voice.jpg"]
    

    
    var dataArray = NSMutableArray()
    //var dataArray1 = NSMutableArray()
    let objApiSync = ApiTrending()
    let objItemsApiSync = ItemsApi()
    var AlbumArray = Array<Any>()
    
    var videoArray = ["snm","snm","snm","snm","snm","snm","snm","snm","snm","snm","snm","snm"]
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
      
          
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        objApiSync.delegeteSyncApi = self
        objTrend.delegeteSyncvideoApi = self
        objItemsApiSync.delegeteSyncApi = self
        
     
        self.collectionView.showsHorizontalScrollIndicator = false
        objTrend.callVideoApi()
        
        
        
        
        
        // Initialization code
    }
    
    func didFinishvideoApi(data: NSMutableArray) {
        //  DispatchQueue.main.async{
        self.dataArray1 = data
        objApiSync.callApi()
        
    }
    
    func didFinishApi(data:NSMutableArray){
        self.dataArray = data
        AlbumArray = ["A Spiritual Journey","A Spiritual Journey","A Spiritual Journey","A Spiritual Journey","A Spiritual Journey","A Spiritual Journey","A Spiritual Journey","A Spiritual Journey","A Spiritual Journey","A Spiritual Journey","A Spiritual Journey"]

        //self.collectionView.reloadData()
       // AppDelegate.appDels.removeHUD()
        objItemsApiSync.callItemsApi()

    }
    func didFinishItemsApi(data: NSMutableArray) {
        self.dataArray2 = data
        self.collectionView.reloadData()
        AppDelegate.appDels.removeHUD()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
        return AlbumArray.count
        } else if collectionView.tag  == 1  {
        return dataArray1.count
        } else if collectionView.tag  == 2 {
            return dataArray2.count
        }else if collectionView.tag  == 3 {
            return maskArray.count
        }else{
    return 0
        }
}
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCollectionViewCell", for: indexPath) as! MyCollectionViewCollectionViewCell
        if collectionView.tag == 0 {
            let imgUrl = dataArray[indexPath.row]
            let image_url1 = (imgUrl as AnyObject).value(forKey: "imgUrl") as! String
            let url = URL(string: image_url1)

            let placeholderImage = UIImage(named: "musicimg.jpeg")!
            cell.imageView.af_setImage(withURL: url!, placeholderImage: placeholderImage)

            return cell
        } else if collectionView.tag == 1 {
            
            let imgUrl = dataArray1[indexPath.row]
            let image_url1 = (imgUrl as AnyObject).value(forKey: "thumnail") as! String
            let url = URL(string: image_url1)

            let title = (imgUrl as AnyObject).value(forKey: "title") as! String
            cell.lbl1.text = title as String
            cell.lbl1.adjustsFontSizeToFitWidth = true
            
            let placeholderImage = UIImage(named: "musicimg.jpeg")!
            cell.imageView.af_setImage(withURL: url!, placeholderImage: placeholderImage)


            return cell
        }
     else if collectionView.tag == 2 {

            let imgUrl = dataArray2[indexPath.row]
            //let image_url1 = (imgUrl as AnyObject).value(forKey: "Image") as! String
            let url = URL(string: imgUrl as! String)

            //let title = (imgUrl as AnyObject).value(forKey: "title") as! String
            //cell.lbl1.text = title as String

            let placeholderImage = UIImage(named: "musicimg.jpeg")!
            cell.imageView.af_setImage(withURL: url!, placeholderImage: placeholderImage)


            return cell
        }
            else if collectionView.tag == 3 {
            cell.imageView.image = UIImage(named : (maskArray[indexPath.row]))
           
            return cell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath)-> CGSize {
        if collectionView.tag == 3 {
            return CGSize(width: collectionView.frame.size.width / 2 - 5, height:200)
        }else{
            return CGSize(width: 95 , height: 95)
        }
        
    }
    var productVC:MusicPlayerVC?
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if collectionView.tag == 0
        {      let imgUrl = dataArray[indexPath.row]
              let mediaUrl = (imgUrl as AnyObject).value(forKey: "mediaUrl") as! String
              let image_url1 = (imgUrl as AnyObject).value(forKey: "imgUrl") as! String
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MusicPlayerVC") as? MusicPlayerVC
           // let vc  = UIStoryboard.in
            vc?.musicVideoURL = mediaUrl
             vc?.musicThumbnail = image_url1
           // NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "food")
            UserDefaults.standard.set(mediaUrl, forKey: "mediaUrl")
            UserDefaults.standard.set(image_url1, forKey: "thumUrl")
            
            productVC?.performSegue(withIdentifier: "player", sender: nil)
            
            UIApplication.topViewController()?.navigationController?.pushViewController(vc!, animated: true)
        }
    if collectionView.tag == 1 {
        
       
        let video = dataArray1[indexPath.row]
        let image_url1 = (video as AnyObject).value(forKey: "linkUrl") as! String
        
        let videoURL = URL(string: image_url1)
        
        let player = AVPlayer(url: videoURL!)
        
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        UIApplication.topViewController()?.present(playerViewController, animated:true, completion: {
            player.play()
        })
        
    } else if collectionView.tag == 2 {
        
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TableviewTrendingViewController") as? TableviewTrendingViewController
               UIApplication.topViewController()?.navigationController?.pushViewController(vc!, animated: true)
        
        }
}
}
// MARK: - UIApplication Extension
extension UIApplication {
    
    /** Returns TopView Controller in the Navigation Stack */
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
