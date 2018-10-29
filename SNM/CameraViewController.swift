//
//  CameraViewController.swift
//  SNM
//
//  Created by Nitin Chauhan on 10/29/18.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit
import MBProgressHUD

class CameraViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,XMLParserDelegate {
    

    @IBOutlet weak var tableView: UITableView!
    
    var names:String = ""
    var uris:String = ""
    var titles: String = ""
    let dataArray =  NSMutableArray()
    var dict = NSMutableDictionary()
    
     var currentParsingElement:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AppDelegate.appDels.showHUD()
        getXMLDataFromServer()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getXMLDataFromServer(){
        let url = NSURL(string: "https://www.youtube.com/feeds/videos.xml?playlist_id=PLyUXlksYcqr__p-T160cXXa2hPUFy_jK-")
        
        //creating data task
        
        let task = URLSession.shared.dataTask(with: url! as URL) { (data, response, error) in
            
            if data == nil{
                print("dataTaskWithRequest error: \(String(describing:error?.localizedDescription))")
                return
            }
            
            let parser = XMLParser(data:data!)
            parser.delegate = self
            parser.parse()
        }
        task.resume()
    }
    
    //MARK:- XML Delegate Methdos
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentParsingElement = elementName
        if elementName == "entry"{
            print("Started Parsing...")
            dict = NSMutableDictionary()
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let foundedChar = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        
        if (!foundedChar.isEmpty){
            if currentParsingElement == "name"{
                dict.setObject(foundedChar, forKey: "Name" as NSCopying)
                names += foundedChar
            }
            else if currentParsingElement == "title"{
                titles += foundedChar
                dict.setObject(foundedChar, forKey: "Title" as NSCopying)
            } else if currentParsingElement == "yt:videoId" {
                let url = "https://img.youtube.com/vi/\(foundedChar)/0.jpg"
                dict.setObject(url, forKey: "ThumbUrl" as NSCopying)
                dict.setObject(foundedChar, forKey: "VideoID" as NSCopying)
            }
            
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "entry" {
            print("Ended parsing...")
            dataArray.add(dict)
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        DispatchQueue.main.async {
            // Update UI
            //self.displayOnUI()
            print(self.dataArray)
            AppDelegate.appDels.removeHUD()
            self.tableView.reloadData()
        }
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("parseErrorOccurred: \(parseError)")
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath)
        let locDict = dataArray[indexPath.row] as! NSMutableDictionary
        cell.textLabel?.text = String(describing: locDict.value(forKey: "Name")!)
        //cell.detailTextLabel?.text = titles
        //        cell.detailTextLabel?.text = String(describing: locDict.value(forKey: "Title")!)
        
        let thumbUrl = URL(string: String(describing: locDict.value(forKey: "ThumbUrl")!))
        do {
            let data = try Data(contentsOf: thumbUrl!)
            cell.imageView?.image = UIImage(data: data)
        } catch let error {
            print(error.localizedDescription)
        }
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let nxtView = self.storyboard?.instantiateViewController(withIdentifier: "VideoPlayerVC") as! VideoPlayerViewController
        let locDict = dataArray[indexPath.row] as! NSMutableDictionary
        nxtView.videoIdentifier = String(describing: locDict.value(forKey: "VideoID")!)
        self.present(nxtView, animated: true, completion: nil)
        //        self.navigationController.pushViewController(showViewController, animated: true)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
