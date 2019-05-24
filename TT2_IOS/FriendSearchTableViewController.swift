//
//  FriendSearchTableViewController.swift
//  TT2_IOS
//
//  Created by KaiHao  on 2019/5/23.
//  Copyright © 2019 NTUST. All rights reserved.
//

import UIKit

class FriendSearchTableViewController: UITableViewController, UISearchResultsUpdating {

    var AllUserList: Array<Dictionary<String, AnyObject>> = []
    var ResultList: Array<Dictionary<String, AnyObject>> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let path = NSHomeDirectory() + "/Documents/Helper.plist"
        if let plist = NSMutableDictionary(contentsOfFile: path) {
            if let API_URL = plist["API_URL"] {
                if let JWT_token = plist["JWT_token"] { // 取得jwt token
                    
                    //指定api的url
                    let url = URL(string: ((API_URL as! String) + "api/contacts/alluser"))
                    
                    var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 30)
                    request.setValue(("Bearer " + (JWT_token as! String)), forHTTPHeaderField: "Authorization")
                    request.httpMethod = "GET"
                    
                    // 使用預設的設定建立 session
                    let config = URLSessionConfiguration.default
                    let session = URLSession(configuration: config)
                    
                    let semaphore = DispatchSemaphore(value: 0) //sync
                    // NSURLSessionDataTask 為讀取資料，讀取完成的資料會放在 data 中
                    let dataTask = session.dataTask(with: request) { (data, response, error) in
                        if let data = data {
                            do {
                                // 解析 JSON
                                // let rrr = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary // 字典
                                let rrr = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! Array<Dictionary<String, AnyObject>> // 字典陣列
                                // print(rrr)
                                
                                // 取出結果
                                self.AllUserList = rrr
                                for r in self.AllUserList {
                                    print("Name: \(r["name"] as! String)")
                                    print("Email: \(r["email"] as! String)")
                                }
                                
                                semaphore.signal() //sync
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    }
                    
                    // 開始讀取資料
                    dataTask.resume()
                    semaphore.wait() //sync
                }
            }
        }
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            ResultList = AllUserList.filter(
                { (r) -> Bool in
                    /*
                    let str1 = (r["name"] as! String).lowercased()
                    let str2 = (r["email"] as! String).lowercased()
                    let key = searchText.lowercased()
                    
                    if(str1.range(of: key) != nil) { return true }
                    else if(str2.range(of: key) != nil) { return true }
                    else { return false }
                    */
                    
                    return ((r["name"] as! String).range(of: searchText, options: .caseInsensitive) != nil ||
                            (r["email"] as! String).range(of: searchText, options: .caseInsensitive) != nil)
                    //return ((r["name"] as! String).localizedCaseInsensitiveContains(searchText) ||
                    //        (r["email"] as! String).localizedCaseInsensitiveContains(searchText))
                }
            )
            tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ResultList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // Configure the cell...
        cell.imageView?.image = UIImage(named: "Friend02")
        cell.textLabel?.text = (ResultList[indexPath.row]["name"] as! String)
        cell.detailTextLabel?.text = (ResultList[indexPath.row]["email"] as! String)
        
        return cell
    }
    
    // 按下item之後會觸發的事件
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let UID = (ResultList[indexPath.row]["uid"] as! Int)
        
        let path = NSHomeDirectory() + "/Documents/Helper.plist"
        if let plist = NSMutableDictionary(contentsOfFile: path) {
            if let API_URL = plist["API_URL"] {
                if let JWT_token = plist["JWT_token"] { // 取得jwt token
                    
                    //指定api的url
                    let url = URL(string: ((API_URL as! String) + "api/contacts/add"))
                    
                    var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 30)
                    request.setValue(("Bearer " + (JWT_token as! String)), forHTTPHeaderField: "Authorization")
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.httpMethod = "POST"
                    request.httpBody = String(UID).data(using: .utf8)
                    
                    // 使用預設的設定建立 session
                    let config = URLSessionConfiguration.default
                    let session = URLSession(configuration: config)
                    
                    // NSURLSessionDataTask 為讀取資料，讀取完成的資料會放在 data 中
                    let dataTask = session.dataTask(with: request) { (data, response, error) in
                        if let data = data {
                            let rrr = String(data: data, encoding: .utf8)
                            print(rrr!)
                            
                            if(rrr == "true")
                            {
                                // 秀出成功加入的訊息
                                DispatchQueue.main.async {
                                    let msg = "\(self.ResultList[indexPath.row]["name"] as! String)(\(self.ResultList[indexPath.row]["email"] as! String)) been added. Please drop down to refresh the list."
                                    let ctr = UIAlertController(title: "Success", message: msg, preferredStyle: .alert)
                                    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                                    ctr.addAction(action)
                                    self.show(ctr, sender: self)
                                }
                            }
                            else
                            {
                                // 秀出加入失敗的訊息
                                DispatchQueue.main.async {
                                    let msg = "Add failed. He may already be your friend."
                                    let ctr = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
                                    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                                    ctr.addAction(action)
                                    self.show(ctr, sender: self)
                                }
                            }
                        }
                    }
                    
                    // 開始讀取資料
                    dataTask.resume()
                }
            }
        }
        
        /*
        let msg = "uid: \(ResultList[indexPath.row]["uid"] as! Int). name: \(ResultList[indexPath.row]["name"] as! String). email: \(ResultList[indexPath.row]["email"] as! String)."
        let ctr = UIAlertController(title: "Selected", message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        ctr.addAction(action)
        present(ctr, animated: true, completion: nil)
        */
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
