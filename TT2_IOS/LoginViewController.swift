//
//  LoginViewController.swift
//  TT2_IOS
//
//  Created by KaiHao  on 2019/5/21.
//  Copyright © 2019 NTUST. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
        
    }

    @IBAction func SignInBtnClick(_ sender: Any) {


        
        
        
        
        
        
        
        let path = NSHomeDirectory() + "/Documents/Helper.plist"
        if let plist = NSMutableDictionary(contentsOfFile: path) {
            if let API_URL = plist["API_URL"] {

                //要送出的資料
                let json: [String: Any] = ["email" : "okh8609@gmail.com" , "password" : "123456788"]
                let jsonData = try? JSONSerialization.data(withJSONObject: json)

                
                //指定api的url
                let url = URL(string: ((API_URL as! String) + "api/account/login"))
  
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
                        let html = String(data: data, encoding: .utf8)
                        print(String(describing: html))
                    }
                }
                
                // 開始讀取資料
                dataTask.resume()
            }
        
        }
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
