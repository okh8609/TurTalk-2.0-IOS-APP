//
//  RegViewController.swift
//  TT2_IOS
//
//  Created by KaiHao  on 2019/5/21.
//  Copyright © 2019 NTUST. All rights reserved.
//

import UIKit

class RegViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var passwd1: UITextField!
    @IBOutlet weak var passwd2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func SubmitClick(_ sender: Any) {
        if(passwd1.text != passwd2.text)
        {
            showMsg(msg: "The password does not match!", foo: nil)
            passwd1.text = ""
            passwd2.text = ""
            return;
        }
        
        
        let path = NSHomeDirectory() + "/Documents/Helper.plist"
        if let plist = NSMutableDictionary(contentsOfFile: path) {
            if let API_URL = plist["API_URL"] {
                
                //要送出的資料
                let json: [String: Any] = ["name" : name.text ?? "",
                                           "email" : email.text ?? "",
                                           "password" : passwd1.text ?? ""]
                let jsonData = try? JSONSerialization.data(withJSONObject: json)
                
                //指定api的url
                let url = URL(string: ((API_URL as! String) + "api/account/reg"))
                
                var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 30)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = jsonData //"x=5&y=3".data(using: .utf8)
                request.httpMethod = "POST"
                
                
                // 使用預設的設定建立 session
                let config = URLSessionConfiguration.default
                let session = URLSession(configuration: config)
                
                // NSURLSessionDataTask 為讀取資料，讀取完成的資料會放在 data 中
                let dataTask = session.dataTask(with: request) { (data, response, error) in
                    if let data = data {
                        let rrr = String(data: data, encoding: .utf8)
                        if(rrr == "true")
                        {
                            print(rrr!)
                            // 秀出註冊成功
                            // 返回上一動
                        }
                        else
                        {
                            print(rrr!)
                            // 秀出註冊失敗
                            // 清除所有欄位
                            // self.showMsg(msg: "Something wrong!", foo: nil)
                            // return;
                        }
                    }
                }
                
                // 開始讀取資料
                dataTask.resume()
            }
        }
    }

    
    
    func showMsg(msg: String, foo: (() -> ())?)
    {
        //create an alert window
        let alertBox = UIAlertController(title: nil,
                                         message: msg,
                                         preferredStyle: .alert)
        
        //create a button with its action
        let okAction = UIAlertAction(title: "OK", style: .default)
        {
            (UIAlertAction) in
            
            if foo != nil
            {
                foo!() //re-display login window
            }
        }
        
        //add action to alert window
        alertBox.addAction(okAction)
        
        //display alert window
        show(alertBox, sender: self)
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
