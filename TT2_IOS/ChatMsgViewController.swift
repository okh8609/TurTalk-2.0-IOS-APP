//
//  ChatMsgViewController.swift
//  TT2_IOS
//
//  Created by KaiHao  on 2019/6/6.
//  Copyright © 2019 NTUST. All rights reserved.
//

import UIKit

class ChatMsgViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView080: UITableView!
    
    let textMsgs = ["1111 111 11111 1111 11 111111 11111 11111 111111",
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
                    "3333 333 33333 33333 33333 333 33333333 333"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Message"
        //navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView080.register(ChatMsgTableViewCell.self, forCellReuseIdentifier: "id2")
        tableView080.separatorStyle = .none
        tableView080.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        tabBarController?.tabBar.isHidden = true
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        
        //cell.textLabel?.text = "TTTT TTTT TTTT"
        //cell.textLabel?.numberOfLines = 0
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