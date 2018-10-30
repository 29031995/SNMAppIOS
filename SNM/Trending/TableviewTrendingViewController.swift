//
//  TableviewTrendingViewController.swift
//  SNM
//
//  Created by Rajlaxmi Shekhawat on 16/10/18.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class TableviewTrendingViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,syncApi {
    
    
    //let objTrend = ApiTrending()
    
   //let timeObj = MusicPlayerVC()
    
    
    var dataArray = NSMutableArray()
    var AlbumArray = ["A Spiritual Journey","A Spiritual Journey","A Spiritual Journey","A Spiritual Journey","A Spiritual Journey","A Spiritual Journey","A Spiritual Journey","A Spiritual Journey","A Spiritual Journey","A Spiritual Journey","A Spiritual Journey"]
    let objApiSync = ApiTrending()
    var avPlayer: AVPlayer!
    var playerState = "play"
    var mediaUrltoPass = String()
    @IBOutlet weak var collView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        objApiSync.delegeteSyncApi = self
        objApiSync.callApi()
        
        let Url = dataArray
        
        let mediaUrl = (Url as AnyObject).value(forKey: "mediaUrl") as! String
        //let mediaUrl = UserDefaults.standard.value(forKey: "mediaUrl") as! String
        self.play(url: URL(string: mediaUrl)!)
        // Do any additional setup after loading the view.
    }
    func didFinishApi(data:NSMutableArray){
        self.dataArray = data
        self.collView.delegate = self as! UICollectionViewDelegate
        self.collView.dataSource = self as! UICollectionViewDataSource
        
        self.collView.reloadData()
        self.table_View.reloadData()
    }
    
    func didFinishItemsApi(data: NSMutableArray) {
        
    }
    
    @IBOutlet weak var table_View: UITableView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func play(url:URL) {
        self.avPlayer = AVPlayer(playerItem: AVPlayerItem(url: url))
        if #available(iOS 10.0, *) {
            self.avPlayer?.automaticallyWaitsToMinimizeStalling = false
        }
        avPlayer!.volume = 1.0
        // avPlayer?.play()
    }
    
    
    
    
    
    
    
    
    //UITableView DATASOURCE
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return dataArray.count

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return  self.view.frame.size.height/10
    }
  
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RecentlyPlayedTrendingTableViewCell
            cell.musicButton.tag = indexPath.row
        
        let imgUrl = dataArray[indexPath.row]
        
        let image_url1 = (imgUrl as AnyObject).value(forKey: "imgUrl") as! String
        let url = URL(string: image_url1)
        if let data = try? Data(contentsOf: url!)
        {
            cell.imgView.image = UIImage(data: data)
        }
          //cell.totalTimeLbl.text = player?.(self.formatTimeFromSeconds(totalSeconds: Int32(CMTimeGetSeconds((avPlayer?.currentItem?.currentTime())!))))
       
//       cell.musicButton.addTarget(self, action: #selector(TableviewTrendingViewController.ClickDeleteBtton(_:)), for: .touchUpInside)
        return cell
  
    
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let imgUrl = dataArray[indexPath.row]
        let image_url1:String = (imgUrl as AnyObject).value(forKey: "imgUrl") as! String
        let Url = dataArray[indexPath.row]
        
        let mediaUrl = (Url as AnyObject).value(forKey: "mediaUrl") as! String
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MusicPlayerVC") as? MusicPlayerVC
//        vc?.imageandMusicArray.append(image_url1)
//        vc?.imageandMusicArray.append(mediaUrl)

        
//        let url = URL(string: image_url1)
//        if let data = try? Data(contentsOf: url!)
//        {
//            vc?.imag.image = UIImage(data: data)
//        }
            self.navigationController?.pushViewController(vc!, animated: true)
    }
   
    
    
//    func ClickDeleteBtton(_ sender: UIButton){
//    let Url = dataArray[sender.tag]
//
//        let mediaUrl = (Url as AnyObject).value(forKey: "mediaUrl") as! String
//      downloadFileFromURL(url: URL(string: mediaUrl)!)
//        mediaUrltoPass = mediaUrl
//        //let mp3 = (Url as AnyObject).value(forKey: "mediaUrl") as! String
//       // let UrklString = Url.ma
//
//
//    }
//    func downloadFileFromURL(url: URL){
//
//        var downloadTask: URLSessionDownloadTask
//        downloadTask = URLSession.shared.downloadTask(with: url as URL, completionHandler: { [weak self](URL, response, error) -> Void in
//            self?.playplayAudio(url: URL!)
//        })
//        downloadTask.resume()
//    }
//    func playplayAudio(url: URL) {
//       // print("playing \(url)")
//
//        do {
//            self.player = try AVAudioPlayer(contentsOf: url as URL)
//            player?.prepareToPlay()
//            player?.volume = 1.0
//            player?.play()
//        } catch let error as NSError {
//            //self.player = nil
//            print(error.localizedDescription)
//        } catch {
//            print("AVAudioPlayer init failed")
//        }
//
//    }
    //COLLECTION VIEW
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
            return AlbumArray.count
       
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! trendingMusicCollectionViewCell
            cell.layer.borderWidth = 0.5
            
            let imgUrl = dataArray[indexPath.row]
            
            let image_url1 = (imgUrl as AnyObject).value(forKey: "imgUrl") as! String
            let url = URL(string: image_url1)
            if let data = try? Data(contentsOf: url!)
            {
                cell.imageCollView.image = UIImage(data: data)
            }
            
            
            return cell
            
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videocell", for: indexPath) as! VideosCollectionViewCell
            cell.layer.borderWidth = 0.5
            //cell.songName.text = videoArray[indexPath.row]
            return cell
        }
        
     
    }
}
