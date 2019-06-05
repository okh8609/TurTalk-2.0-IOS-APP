//
//  FriendListTableViewController.swift
//  TT2_IOS
//
//  Created by KaiHao  on 2019/5/23.
//  Copyright © 2019 NTUST. All rights reserved.
//

import UIKit

class FriendListTableViewController: UITableViewController {

    var ContactList: Array<Dictionary<String, AnyObject>> = []
    var searchCtrl: UISearchController!
    
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
                    let url = URL(string: ((API_URL as! String) + "api/contacts/list"))
                    
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
                                self.ContactList = rrr
                                for r in self.ContactList {
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
                    
                    // 利用它載入資料的時間，產生搜尋列:
                    if let vc = storyboard?.instantiateViewController(withIdentifier: "FriendSearchResult") as? FriendSearchTableViewController
                    {
                        searchCtrl = UISearchController(searchResultsController: vc)
                        searchCtrl.searchResultsUpdater = vc
                        searchCtrl.dimsBackgroundDuringPresentation = false
                        tableView.tableHeaderView = searchCtrl.searchBar
                    }
                    // 搜尋列產生完畢.
                    
                    // 利用它載入資料的時間，設定下拉更新:
                    tableView.refreshControl = UIRefreshControl()
                    tableView.refreshControl?.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
                    // 設定完畢.
                    
                    semaphore.wait() //sync
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
                    let url = URL(string: ((API_URL as! String) + "api/contacts/list"))
                    
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
                                self.ContactList = rrr
                                for r in self.ContactList {
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
        
        // 停止下拉後的動畫特效並復原表格位置
        tableView.refreshControl?.endRefreshing()
        // 要表格重新載入資料
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ContactList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...
        cell.imageView?.image = UIImage(named: "Friend01")
        cell.textLabel?.text = (ContactList[indexPath.row]["name"] as! String)
        cell.detailTextLabel?.text = (ContactList[indexPath.row]["email"] as! String)

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            deleteFriend(ContactList[indexPath.row]["uid"] as! Int)
            ContactList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    func deleteFriend(_ UID: Int)
    {
        let path = NSHomeDirectory() + "/Documents/Helper.plist"
        if let plist = NSMutableDictionary(contentsOfFile: path) {
            if let API_URL = plist["API_URL"] {
                if let JWT_token = plist["JWT_token"] { // 取得jwt token
                    
                    //指定api的url
                    let url = URL(string: ((API_URL as! String) + "api/contacts/del"))
                    
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
                        }
                    }
                    
                    // 開始讀取資料
                    dataTask.resume()
                }
            }
        }
    }

    // 按下item之後會觸發的事件
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowTimer2", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dst = segue.destination as? ChatTimerViewController{
            dst.UID = (ContactList[(tableView.indexPathForSelectedRow?.row)!]["uid"] as! Int)
            tableView.deselectRow(at: (tableView.indexPathForSelectedRow)!, animated: true)
        }
    }
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
