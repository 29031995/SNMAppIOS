//
//  VideoPlayerViewController.swift
//  SNM
//
//  Created by Nitin Chauhan on 10/29/18.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit
import XCDYouTubeKit

class VideoPlayerViewController: UIViewController{
    
    
     var videoIdentifier = ""
     @IBOutlet weak var playerContainerview: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let player = XCDYouTubeVideoPlayerViewController(videoIdentifier: videoIdentifier)
        player.present(in: self.playerContainerview)
        player.moviePlayer.play()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func cancelBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil
        )
    }
    
//    @IBAction func cancelBtn(_ sender: Any) {
//        //navigationController?.popViewController(animated: true)
//
//        dismiss(animated: true, completion: nil)
//    }
//
//    @IBAction func cancelBtn(_ sender: Any) {
//        //navigationController?.popViewController(animated: true)
//
//        dismiss(animated: true, completion: nil)
//    }

   
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


