//
//  RecentlyPlayedTrendingTableViewCell.swift
//  SNM
//
//  Created by Rajlaxmi Shekhawat on 16/10/18.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class RecentlyPlayedTrendingTableViewCell: UITableViewCell {
var playerState = "play"
    var avPlayer: AVPlayer!
    var isPaused: Bool!
    @IBOutlet weak var musicButton: UIButton!
    @IBOutlet weak var pauseBtn: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var totalTimeLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func btn_Action(_ sender: UIButton) {
        if avPlayer.timeControlStatus == .playing  {
            musicButton.setImage(UIImage(named:"pla"), for: .normal)
            avPlayer.pause()
            isPaused = true
        } else {
            musicButton.setImage(UIImage(named:"pause"), for: .normal)
            avPlayer.play()
            isPaused = false
        }
    }
    }
//extension AVPlayer {
//    var isPlaying: Bool {
//        return rate != 0 && error == nil
//    }
//}
