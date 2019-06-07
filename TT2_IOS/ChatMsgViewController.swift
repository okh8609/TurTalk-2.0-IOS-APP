//
//  ChatMsgViewController.swift
//  TT2_IOS
//
//  Created by KaiHao  on 2019/6/6.
//  Copyright © 2019 NTUST. All rights reserved.
//

import UIKit

class ChatMsgViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var UID: Int?
    var eff_t: String?
    
    @IBOutlet weak var tableView080: UITableView!
    var tableView080BtmConstraint: NSLayoutConstraint?
    
    let msgBar = MsgInputBarUIView()
    let msgBarHeight = CGFloat(48)
    var magBarBtmConstraint: NSLayoutConstraint?

    
    let textMsgs = ["@1111 111 11111 1111 11 111111 11111 11111 111111",
                    "22222 222 2222 2222 2222 22 22222 222222222 222 22222",
                    "333 3333 333 333 3333 33333 333333 333 33333",
                    "11 111 11 11 111 1111 1111 111 11111 111 111 111111",
                    "22 222 2222 22 22 222 222 2222 22 22 2222 2222 22 222222",
                    "333333 33333 333333 33333333 33333 333333",
                    "111111 1111 1111111 111111 1111 1111 1111 11111",
                    "22222 222 2222 2222 2222 22222 222 22222 222 222 22222",
                    "333 3333 333 333 3333 333 33333 333333 33333",
                    "1111 11 1111111 1111 1111 11 1111 1111 1111 11111",
                    "222 22222 22222 222 222222 222222 2 2222222 22 222222",
                    "3333 333 33333 33333 33333 333 33333333 333@"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // print(UID)
        // print(eff_t)
        
        navigationItem.title = "Message"
        //navigationController?.navigationBar.prefersLargeTitles = true
        tabBarController?.tabBar.isHidden = true
        
        tableView080.register(ChatMsgTableViewCell.self, forCellReuseIdentifier: "id2")
        tableView080.separatorStyle = .none
        tableView080.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        tableView080.translatesAutoresizingMaskIntoConstraints = false
        tableView080.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView080BtmConstraint = NSLayoutConstraint(item: tableView080, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -msgBarHeight)
        view.addConstraint(tableView080BtmConstraint!)
        tableView080.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView080.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
        msgBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(msgBar)
        msgBar.heightAnchor.constraint(equalToConstant: msgBarHeight).isActive = true
        msgBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        msgBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        magBarBtmConstraint = NSLayoutConstraint(item: msgBar, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        view.addConstraint(magBarBtmConstraint!)
        //msgBar.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        //msgBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHandler), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHandler), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        msgBar.sendBtn.addTarget(self, action: #selector(sendBtnClick), for: .touchUpInside)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc func keyboardHandler(notification: NSNotification)
    {
        if let userInfo = notification.userInfo{
            
            let keyboardFrame = ((userInfo[UIResponder.keyboardFrameEndUserInfoKey]) as AnyObject).cgRectValue
            //print(keyboardFrame!)
            
            let isShowing = notification.name == UIResponder.keyboardWillShowNotification
            
            tableView080BtmConstraint?.constant = isShowing ? (-keyboardFrame!.height - msgBarHeight) : (-msgBarHeight)
            magBarBtmConstraint?.constant = isShowing ? -keyboardFrame!.height : 0
            
            UIView.animate(withDuration: 0, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: { (completed) in
                if isShowing {
                    let idx = IndexPath(row: self.textMsgs.count - 1, section: 0)
                    self.tableView080.scrollToRow(at: idx, at: .bottom, animated: true)
                }
            })
        }
    }
    
    @objc func sendBtnClick(_ sender: UIButton) {
        if( self.msgBar.textBox.text=="" || self.msgBar.textBox.text == nil)
        {
            print("empty msg!")
            return
        }
        
        let path = NSHomeDirectory() + "/Documents/Helper.plist"
        if let plist = NSMutableDictionary(contentsOfFile: path) {
            if let API_URL = plist["API_URL"] {
                if let JWT_token = plist["JWT_token"] { // 取得jwt token
                    
                    //要送出的資料
                    let json: [String: Any] = ["uid" : self.UID ?? 0,
                                               "message" : self.msgBar.textBox.text ?? "",
                                               "eff_period" : self.eff_t ?? ""]
                    let jsonData = try? JSONSerialization.data(withJSONObject: json)
                    
                    print(String(data: jsonData!, encoding: .utf8)!)
                    
                    //指定api的url
                    let url = URL(string: ((API_URL as! String) + "api/chat2/send"))
                    
                    var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 30)
                    request.setValue(("Bearer " + (JWT_token as! String)), forHTTPHeaderField: "Authorization")
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.httpBody = jsonData
                    request.httpMethod = "POST"
                    
                    
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
                                // 更新table view
                                DispatchQueue.main.async{
                                        
                                        
                                }
                            }
                        }
                    }
                    
                    // 開始讀取資料
                    dataTask.resume()
                    
                    msgBar.textBox.text = ""
                }
            }
        }
    }
    
    //按下item
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //magBarBtmConstraint?.constant = 0
        msgBar.textBox.endEditing(true)
        tableView.deselectRow(at: (tableView.indexPathForSelectedRow)!, animated: true)
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return textMsgs.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "id2", for: indexPath) as!ChatMsgTableViewCell
        
        // Configure the cell...
        cell.msgLabel.text = textMsgs[indexPath.row]
        cell.isMyMsg = indexPath.row % 2 == 0
        
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
