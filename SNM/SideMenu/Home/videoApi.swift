//
//  videoApi.swift
//  SNM
//
//  Created by Rajlaxmi Shekhawat on 18/10/18.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit
import Alamofire
protocol syncvideoApi{
    func didFinishvideoApi(data:NSMutableArray)
    
}

class videoApi: NSObject {
var delegeteSyncvideoApi : syncvideoApi!
    
    
   // var dataArray = NSMutableArray()
    var dataArray1 = NSMutableArray()
    let mainUrl = "http://146.20.3.64:1001/api/videos"
    
    func callVideoApi(){
        
        let urls  = URL(string: mainUrl)
        Alamofire.request(urls!).responseJSON { (response) in
            print(response.result)
            switch(response.result) {
            case .success(_):
                if let dataDic  = response.result.value as? NSDictionary{
                    let arry = dataDic.value(forKey: "videos") as! NSArray
                    
                    
                    for i in 0 ..< arry.count {
                        let dicData = NSMutableDictionary()
                        
                        let dict = arry.object(at: i) as! NSDictionary
                        let mediaUrl = dict.value(forKey: "linkUrl") as! String
                        let thumnail = dict.value(forKey: "thumbnailUrl") as! String
                        let title = dict.value(forKey: "title") as! String
//                        let channel = dict.object(forKey: "channel") as! NSDictionary
//                        let imgUrl = channel.value(forKey: "imageUrl") as! String
                        dicData.setValue(mediaUrl, forKey: "linkUrl")
                        dicData.setValue(thumnail, forKey: "thumnail")
                        dicData.setValue(title, forKey: "title")
                        
                        self.dataArray1.add(dicData)
                        
                    }
                    self.delegeteSyncvideoApi.didFinishvideoApi(data: self.dataArray1)
                    
                    
                }
                
                
            case .failure(_):
                print(response.result.error! )
                break
                //completion(nil,false)
            }
            
        }
        
    }
    
}
