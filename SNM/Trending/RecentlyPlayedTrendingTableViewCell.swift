//
//  RecentlyPlayedTrendingTableViewCell.swift
//  SNM
//
//  Created by Rajlaxmi Shekhawat on 16/10/18.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit
import AVFoundation

class RecentlyPlayedTrendingTableViewCell: UITableViewCell {
var playerState = "play"
    var player: AVAudioPlayer?
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
        if playerState == "play"
        {player?.pause()
            sender.setImage(UIImage(named: "pause"), for: .normal)
            playerState = "pause"
        }
            
        else{
            player?.play()
            playerState = "play"
            sender.setImage(UIImage(named: "pla"), for: .normal)
        }
    }
    }

