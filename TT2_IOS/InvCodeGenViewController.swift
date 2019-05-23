//
//  InvCodeGenViewController.swift
//  TT2_IOS
//
//  Created by KaiHao  on 2019/5/22.
//  Copyright © 2019 NTUST. All rights reserved.
//

import UIKit

class InvCodeGenViewController: UIViewController {


    @IBOutlet weak var id: UITextField!
    @IBOutlet weak var passwd: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // 取得臨時帳號
        let path = NSHomeDirectory() + "/Documents/Helper.plist"
        if let plist = NSMutableDictionary(contentsOfFile: path) {
            if let API_URL = plist["API_URL"] {                
                if let JWT_token = plist["JWT_token"] { // 取得jwt token
                    
                    //指定api的url
                    let url = URL(string: ((API_URL as! String) + "api/invite/getacc"))
                    
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
                                    self.id.text = String(rrr["uid"] as! Int)
                                    self.passwd.text = (rrr["pwd"] as! String)
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
        
        // 讓使用者不可編輯
        // id.isUserInteractionEnabled = false
        // passwd.isUserInteractionEnabled = false
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
