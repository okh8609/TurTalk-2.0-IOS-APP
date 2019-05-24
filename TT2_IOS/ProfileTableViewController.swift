//
//  ProfileTableViewController.swift
//  TT2_IOS
//
//  Created by KaiHao  on 2019/5/24.
//  Copyright © 2019 NTUST. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
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
                    let url = URL(string: ((API_URL as! String) + "api/account/profile"))
                    
                    var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 30)
                    request.setValue(("Bearer " + (JWT_token as! String)), forHTTPHeaderField: "Authorization")
                    request.httpMethod = "GET"
                    
                    // 使用預設的設定建立 session
                    let config = URLSessionConfiguration.default
                    let session = URLSession(configuration: config)
                    
                    // NSURLSessionDataTask 為讀取資料，讀取完成的資料會放在 data 中
                    let dataTask = session.dataTask(with: request) { (data, response, error) in
                        if let data = data {
                            do {
                                // 解析 JSON
                                let rrr = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                                
                                // 取出結果
                                print(rrr)
                                DispatchQueue.main.async {
                                    self.nameLabel.text = (rrr["name"] as! String)
                                    self.emailLabel.text = (rrr["email"] as! String)
                                }                                
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    }
                    
                    // 開始讀取資料
                    dataTask.resume()
                    
                    // 利用它載入資料的時間，設定一些東西
                    
                    //下拉更新:
                    tableView.refreshControl = UIRefreshControl()
                    tableView.refreshControl?.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
                    
                    //label字體自動變小
                    self.nameLabel.adjustsFontSizeToFitWidth = true;
                    self.emailLabel.adjustsFontSizeToFitWidth = true;
                    
                }
            }
        }        
    }
    
    
    @objc func handleRefresh() {
        
        let path = NSHomeDirectory() + "/Documents/Helper.plist"
        if let plist = NSMutableDictionary(contentsOfFile: path) {
            if let API_URL = plist["API_URL"] {
                if let JWT_token = plist["JWT_token"] { // 取得jwt token
                    
                    //指定api的url
                    let url = URL(string: ((API_URL as! String) + "api/account/profile"))
                    
                    var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 30)
                    request.setValue(("Bearer " + (JWT_token as! String)), forHTTPHeaderField: "Authorization")
                    request.httpMethod = "GET"
                    
                    // 使用預設的設定建立 session
                    let config = URLSessionConfiguration.default
                    let session = URLSession(configuration: config)
                    
                    // NSURLSessionDataTask 為讀取資料，讀取完成的資料會放在 data 中
                    let dataTask = session.dataTask(with: request) { (data, response, error) in
                        if let data = data {
                            do {
                                // 解析 JSON
                                let rrr = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                                
                                // 取出結果
                                DispatchQueue.main.async {
                                    self.nameLabel.text = (rrr["name"] as! String)
                                    self.emailLabel.text = (rrr["email"] as! String)
                                }
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    }
                    
                    // 開始讀取資料
                    dataTask.resume()
                }
            }
        }
                    
        // 停止下拉後的動畫特效並復原表格位置
        tableView.refreshControl?.endRefreshing()
        // 要表格重新載入資料
        tableView.reloadData()
    }

    @IBAction func unwindToProfile(for segue: UIStoryboardSegue) {
        
        let path = NSHomeDirectory() + "/Documents/Helper.plist"
        if let plist = NSMutableDictionary(contentsOfFile: path) {
            if let API_URL = plist["API_URL"] {
                if let JWT_token = plist["JWT_token"] { // 取得jwt token
                    
                    //指定api的url
                    let url = URL(string: ((API_URL as! String) + "api/account/profile"))
                    
                    var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 30)
                    request.setValue(("Bearer " + (JWT_token as! String)), forHTTPHeaderField: "Authorization")
                    request.httpMethod = "GET"
                    
                    // 使用預設的設定建立 session
                    let config = URLSessionConfiguration.default
                    let session = URLSession(configuration: config)
                    
                    // NSURLSessionDataTask 為讀取資料，讀取完成的資料會放在 data 中
                    let dataTask = session.dataTask(with: request) { (data, response, error) in
                        if let data = data {
                            do {
                                // 解析 JSON
                                let rrr = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                                
                                // 取出結果
                                DispatchQueue.main.async {
                                    self.nameLabel.text = (rrr["name"] as! String)
                                    self.emailLabel.text = (rrr["email"] as! String)
                                }
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    }
                    
                    // 開始讀取資料
                    dataTask.resume()
                }
            }
        }
    }
    // MARK: - Table view data source
/*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
*/
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
