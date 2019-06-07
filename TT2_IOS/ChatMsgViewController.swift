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
    var magBarBtmConstraint: NSLayoutConstraint?
    
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
    
    let msgBar: UIView = {
        let theView = UIView()
        theView.backgroundColor = UIColor.lightGray
        
        let textBox = UITextField()
        textBox.placeholder = "Enter message..."
        textBox.translatesAutoresizingMaskIntoConstraints = false
        theView.addSubview(textBox)
        textBox.leadingAnchor.constraint(equalTo: theView.leadingAnchor, constant: 16).isActive = true
        textBox.trailingAnchor.constraint(equalTo: theView.trailingAnchor, constant: 0).isActive = true
        textBox.bottomAnchor.constraint(equalTo: theView.bottomAnchor, constant: 0).isActive = true
        textBox.topAnchor.constraint(equalTo: theView.topAnchor, constant: 0).isActive = true
        
        return theView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Message"
        //navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView080.register(ChatMsgTableViewCell.self, forCellReuseIdentifier: "id2")
        tableView080.separatorStyle = .none
        tableView080.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        tabBarController?.tabBar.isHidden = true
        
        msgBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(msgBar)
        msgBar.heightAnchor.constraint(equalToConstant: 48).isActive = true
        msgBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        msgBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        magBarBtmConstraint = NSLayoutConstraint(item: msgBar, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        view.addConstraint(magBarBtmConstraint!)
        //msgBar.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        //msgBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShowHandler), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc func keyboardShowHandler(notification: NSNotification)
    {
        if let userInfo = notification.userInfo{
            
            let keyboardFrame = ((userInfo[UIResponder.keyboardFrameEndUserInfoKey]) as AnyObject).cgRectValue
            print(keyboardFrame!)
            
            magBarBtmConstraint?.constant = -keyboardFrame!.height
        }
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
