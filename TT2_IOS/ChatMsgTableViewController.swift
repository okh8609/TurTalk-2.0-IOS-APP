//
//  ChatTableViewController.swift
//  TT2_IOS
//
//  Created by KaiHao  on 2019/6/5.
//  Copyright © 2019 NTUST. All rights reserved.
//

import UIKit

class ChatMsgTableViewController: UITableViewController {

    let textMsgs = ["111111 11111111111  111111  11111111  111111111","2222222222222222 222222222222 22222222 22222222","33333333333333333  33333333 33333333333","111111 11111111111  111111  11111111  111111111","2222222222222222 222222222222 22222222 22222222","33333333333333333  33333333 33333333333"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Message"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(ChatMsgTableViewCell.self, forCellReuseIdentifier: "id2")
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return textMsgs.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "id2", for: indexPath) as!ChatMsgTableViewCell

        // Configure the cell...

        //cell.textLabel?.text = "TTTT TTTT TTTT"
        //cell.textLabel?.numberOfLines = 0
        cell.msgLabel.text = textMsgs[indexPath.row]
        cell.isMyMsg = indexPath.row % 2 == 0
        
        return cell
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
