//
//  ApiTrending.swift
//  SNM
//
//  Created by Rajlaxmi Shekhawat on 15/10/18.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit
import Alamofire
protocol syncApi{
     func didFinishApi(data:NSMutableArray)
   }
typealias serverResponse = (_ : NSMutableArray?,_ : Bool)->Void

class ApiTrending: NSObject {
    
     var delegeteSyncApi : syncApi!
     var dataArray = NSMutableArray()
     var dataArray1 = NSMutableArray()
    let mainUrl = "http://146.20.3.64:1001/api/trending"
   
    func callApi(){
        
      let urls  = URL(string: mainUrl)
        Alamofire.request(urls!).responseJSON { (response) in
            print(response.result)
            switch(response.result) {
            case .success(_):
                if let dataDic  = response.result.value as? NSDictionary{
                    let arry = dataDic.value(forKey: "trending") as! NSArray
                
                   
                    for i in 0 ..< arry.count {
                        let dicData = NSMutableDictionary()

                        let dict = arry.object(at: i) as! NSDictionary
                        let mediaUrl = dict.value(forKey: "mediaUrl") as! String

                        let channel = dict.object(forKey: "channel") as! NSDictionary
                        let imgUrl = channel.value(forKey: "imageUrl") as! String
                        dicData.setValue(mediaUrl, forKey: "mediaUrl")
                         dicData.setValue(imgUrl, forKey: "imgUrl")

                        self.dataArray.add(dicData)

                    }
                    self.delegeteSyncApi.didFinishApi(data: self.dataArray)
                    
                    
            }
                
                
            case .failure(_):
                print(response.result.error! )
                break
                //completion(nil,false)
            }

        }

    }
    
}


