//
//  MusicPlayerVC.swift
//  SNM
//
//  Created by Administrator on 08/09/18.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import AlamofireImage



class MusicPlayerVC: UIViewController, FSPagerViewDataSource, FSPagerViewDelegate,syncApi{
 
    

    
    @IBOutlet weak var playButton: UIButton!
    var musicThumbnail = String()
    var musicVideoURL = String()
    var thumbnailArray = [String]()

    @IBOutlet weak var previousBtn: UIButton!
    @IBOutlet weak var nextbtn: UIButton!
    
    @IBOutlet weak var totalDurationLbl: UILabel!
    @IBOutlet weak var currentTimeLbl: UILabel!
    @IBOutlet weak var playerSlider: UISlider!
    var playerState = "play"
    var dataArray = NSMutableArray()
    let objApiSync = ApiTrending()
    
    var playList: NSMutableArray = NSMutableArray()
    var timer: Timer?
    var index: Int = Int()
    var avPlayer: AVPlayer!
    var isPaused: Bool!
    
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        }
    }
    
    func didFinishApi(data:NSMutableArray){
        AppDelegate.appDels.removeHUD()
        self.dataArray = data
        for i in 0...dataArray.count - 1 {
            let img = dataArray[i]
           // let tumbNail = (img as AnyObject).value(forKey: "imgUrl") as! String
            let mediaUrl = (img as AnyObject).value(forKey: "mediaUrl") as! String
            playList.add(mediaUrl)
            //let url = URL(string: tumbNail)
        }
        self.pagerView.delegate = self
        self.pagerView.dataSource = self
        self.pagerView.reloadData()
        if indexs == 0 {
            previousBtn.isEnabled = false
        }
        else if indexs == dataArray.count - 1 {
            nextbtn.isEnabled = false
        }
        
    }
   
 
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
      //  avPlayer.pause()
        self.avPlayer = nil
        self.timer?.invalidate()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
     
    }
    
    var videoArray = ["snm","snm","snm","snm","snm","snm","snm","snm","snm","snm","snm","snm"]
    var indexs = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            print("AVAudioSession Category Playback OK")
            do {
                try AVAudioSession.sharedInstance().setActive(true)
                print("AVAudioSession is Active")
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        playerSlider.setThumbImage(UIImage(named: "barTumbler.png"), for: UIControlState.normal)
        objApiSync.delegeteSyncApi = self
        AppDelegate.appDels.showHUD()
        objApiSync.callApi()
        self.pagerView.transformer = FSPagerViewTransformer(type:.linear)
        let transform = CGAffineTransform(scaleX: 0.8, y: 0.95)
        self.pagerView.itemSize = self.pagerView.frame.size.applying(transform)
        
        
        let mediaUrl = UserDefaults.standard.value(forKey: "mediaUrl") as! String
        self.play(url: URL(string: mediaUrl)!)
        self.setupTimer()
    }
    
    func setupTimer(){
       // NotificationCenter.default.addObserver(self, selector: #selector(self.didPlayToEnd), name: .AVPlayerItemDidPlayToEndTime, object: nil)
        timer = Timer(timeInterval: 0.001, target: self, selector: #selector(MusicPlayerVC.tick), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: RunLoopMode.commonModes)
    }
    
    func didPlayToEnd() {
        self.nextTrack()
    }
    
    func tick(){
        
        if(isPaused == false){
            if(avPlayer.rate == 0){
                avPlayer.play()
            }
        }
        
        if((avPlayer.currentItem?.asset.duration) != nil){
            let currentTime1 : CMTime = (avPlayer.currentItem?.asset.duration)!
            let seconds1 : Float64 = CMTimeGetSeconds(currentTime1)
            let time1 : Float = Float(seconds1)
            playerSlider.minimumValue = 0
            playerSlider.maximumValue = time1
            let currentTime : CMTime = (self.avPlayer?.currentTime())!
            let seconds : Float64 = CMTimeGetSeconds(currentTime)
            let time : Float = Float(seconds)
            self.playerSlider.value = time
            totalDurationLbl.text =  self.formatTimeFromSeconds(totalSeconds: Int32(Float(Float64(CMTimeGetSeconds((self.avPlayer?.currentItem?.asset.duration)!)))))
            currentTimeLbl.text = self.formatTimeFromSeconds(totalSeconds: Int32(Float(Float64(CMTimeGetSeconds((self.avPlayer?.currentItem?.currentTime())!)))))
            
        }else{
            playerSlider.value = 0
            playerSlider.minimumValue = 0
            playerSlider.maximumValue = 0
            totalDurationLbl.text = "Live stream \(self.formatTimeFromSeconds(totalSeconds: Int32(CMTimeGetSeconds((avPlayer.currentItem?.currentTime())!))))"
        }
    }
    
    
    func nextTrack(){
        
        if(index < playList.count-1){
            index = index + 1
            isPaused = false
            playButton.setImage(UIImage(named:"pause"), for: .normal)
            self.play(url: URL(string:(playList[self.index] as! String))!)
            setupTimer()
            
            
        }else{
            index = 0
            isPaused = false
            playButton.setImage(UIImage(named:"pause"), for: .normal)
            self.play(url: URL(string:(playList[self.index] as! String))!)
            setupTimer()
        }
    }
    
    func prevTrack(){
        if(index > 0){
            index = index - 1
            isPaused = false
            playButton.setImage(UIImage(named:"pause"), for: .normal)
            self.play(url: URL(string:(playList[self.index] as! String))!)
            setupTimer()
            
        }
    }
    
    func formatTimeFromSeconds(totalSeconds: Int32) -> String {
        let seconds: Int32 = totalSeconds%60
        let minutes: Int32 = (totalSeconds/60)%60
        //let hours: Int32 = totalSeconds/3600
        return String(format: "%02d:%02d",minutes,seconds)
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.dismiss(animated: true) {
            self.avPlayer.pause()
            self.avPlayer = nil
            self.timer?.invalidate()
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        playerState = "stop"
        
    }
    
    //MARK: Play audio
    func play(url:URL) {
        if indexs == 0 {
            previousBtn.isEnabled = false
        }
        else {
            previousBtn.isEnabled = true
        }
        if indexs == dataArray.count - 1 {
            nextbtn.isEnabled = false
        }
        else {
            nextbtn.isEnabled = true
        }
        self.avPlayer = AVPlayer(playerItem: AVPlayerItem(url: url))
        if #available(iOS 10.0, *) {
            self.avPlayer?.automaticallyWaitsToMinimizeStalling = false
        }
        avPlayer!.volume = 1.0
       // avPlayer?.play()
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return dataArray.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
         //let imgUrl = dataArray[indexPath.row]
        
       // let tumbNail = thumbnailArray[pagerView.currentIndex]
        let img = dataArray[index]
        let tumbNail = (img as AnyObject).value(forKey: "imgUrl") as! String
        let url = URL(string: tumbNail)
        let placeholderImage = UIImage(named: "musicimg.jpeg")!
        cell.imageView?.af_setImage(withURL: url!, placeholderImage: placeholderImage)
//        if let data = try? Data(contentsOf: url!)
//        {
//            cell.imageView?.image = UIImage(data: data)
//        }
        
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        self.indexs = pagerView.currentIndex
      
        return cell
    }
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        self.indexs = index
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
        self.avPlayer.pause()
        self.avPlayer = nil
        self.timer?.invalidate()
        self.playerSlider.setValue(0, animated: true)
        
        isPaused = false
        playButton.setImage(UIImage(named:"pause"), for: .normal)
        self.play(url: URL(string:(playList[self.index] as! String))!)
        setupTimer()
    }
    
    
//    func pagerViewDidScroll(_ pagerView: FSPagerView) {
//        self.avPlayer.pause()
//        self.avPlayer = nil
//        self.timer?.invalidate()
//
//        isPaused = false
//        playButton.setImage(UIImage(named:"pause"), for: .normal)
//        self.play(url: URL(string:(playList[pagerView.currentIndex] as! String))!)
//        setupTimer()
//    }
    
    func pagerViewDidEndDecelerating(_ pagerView: FSPagerView) {
                self.avPlayer.pause()
                self.avPlayer = nil
                self.timer?.invalidate()
        self.playerSlider.setValue(0, animated: true)

                isPaused = false
                playButton.setImage(UIImage(named:"pause"), for: .normal)
                self.play(url: URL(string:(playList[pagerView.currentIndex] as! String))!)
                setupTimer()
    }
    
    
    
    @IBAction func prevSongPlay(_ sender: UIButton) {
        indexs = indexs - 1
        pagerView.deselectItem(at: indexs, animated: true)
        pagerView.scrollToItem(at: indexs, animated: true)

        timer?.invalidate()
        self.playerSlider.setValue(0, animated: true)

        prevTrack()
       
    }
    
    @IBAction func nextSongPlay(_ sender: UIButton) {
        indexs = indexs + 1
        pagerView.deselectItem(at: indexs, animated: true)
        pagerView.scrollToItem(at: indexs, animated: true)

        timer?.invalidate()
        self.playerSlider.setValue(0, animated: true)

        nextTrack()
 //   avPlayer = nil
    }
    
    @IBAction func playSongAction(_ sender: UIButton) {
        
        self.togglePlayPause()
        
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        let seconds : Int64 = Int64(sender.value)
        let targetTime:CMTime = CMTimeMake(seconds, 1)
        avPlayer!.seek(to: targetTime)
    }
    
    func togglePlayPause() {
        if avPlayer.timeControlStatus == .playing  {
            playButton.setImage(UIImage(named:"pla"), for: .normal)
            avPlayer.pause()
            isPaused = true
        } else {
            playButton.setImage(UIImage(named:"pause"), for: .normal)
            avPlayer.play()
            isPaused = false
        }
    }
    

}

extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}


extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
