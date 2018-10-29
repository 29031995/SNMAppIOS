//
//  ItemsApi.swift
//  SNM
//
//  Created by Ujjwal Madan on 26/10/18.
//  Copyright © 2018 Administrator. All rights reserved.
//

import Foundation

import UIKit
import Alamofire
protocol syncItemsApi{
    func didFinishItemsApi(data:NSMutableArray)
}

class ItemsApi: NSObject {
    
    var delegeteSyncApi : syncItemsApi?
    var dataArray = NSMutableArray()
    var dataArray1 = NSMutableArray()
    let mainUrl = "http://146.20.3.64:1001/api/items"
    
    func callItemsApi(){
        
        let urls  = URL(string: mainUrl)
        Alamofire.request(urls!).responseJSON { (response) in
            print(response.result)
            switch(response.result) {
            case .success(_):
                if let dataDic  = response.result.value as? NSDictionary{
                    let arry = dataDic.value(forKey: "items") as! NSArray
                    
                    
                    for i in 0 ..< arry.count {
                  //      let dicData = NSMutableDictionary()
                        
                        let dict = arry.object(at: i) as! NSDictionary
                    //    let mediaUrl = dict.value(forKey: "mediaUrl") as? String ?? ""
                        
                      if let channel = dict.object(forKey: "channel") as? NSDictionary
                      {
                        let imgUrl = channel.value(forKey: "imageUrl") as? String ?? ""
                        self.dataArray.add(imgUrl)

                        }
                        //dicData.setValue(mediaUrl, forKey: "Media")
                       // dicData.setValue(imgUrl, forKey: "Image")
                        
                        
                    }
                    self.delegeteSyncApi?.didFinishItemsApi(data: self.dataArray)
                    
                    
                }
                
                
            case .failure(_):
                print(response.result.error! )
                break
                //completion(nil,false)
            }
            
        }
        
    }
    
}
