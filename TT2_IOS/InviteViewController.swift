//
//  InviteViewController.swift
//  TT2_IOS
//
//  Created by KaiHao  on 2019/5/21.
//  Copyright © 2019 NTUST. All rights reserved.
//

import UIKit

class InviteViewController: UIViewController {

    @IBOutlet weak var trialID: UITextField!
    @IBOutlet weak var trialPwd: UITextField!
    
    var ancestorUID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.3) {
            self.view.endEditing(true)
        }
    }
    
    @IBAction func GoBtnClick(_ sender: UIButton) {
        let path = NSHomeDirectory() + "/Documents/Helper.plist"
        if let plist = NSMutableDictionary(contentsOfFile: path) {
            if let API_URL = plist["API_URL"] {
                
                //要送出的資料
                let json: [String: Any] = ["uid" : trialID.text ?? "" , "pwd" : trialPwd.text ?? ""]
                let jsonData = try? JSONSerialization.data(withJSONObject: json)
                
                //指定api的url
                let url = URL(string: ((API_URL as! String) + "api/invite/login"))
                var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 30)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = jsonData
                request.httpMethod = "POST"
                
                let config = URLSessionConfiguration.default
                let session = URLSession(configuration: config)
                
                // NSURLSessionDataTask 為讀取資料，讀取完成的資料會放在 data 中
                let dataTask = session.dataTask(with: request) { (data, response, error) in
                    if let data = data {
                        do {
                            // 解析 JSON
                            let rrr = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                            
                            // 取出結果
                            // print("D1: \(rrr["Success"] as! Bool)")
                            // print("D2: \(rrr["Message"] as! String)")
                            // print("D3: \(rrr["Payload"] as! String)")
                            
                            if(rrr["Success"] as! Bool){
                                // 更新 JWT Token
                                plist["JWT_token"] = (rrr["Payload"] as! String)//.trimmingCharacters(in: .whitespaces)
                                if plist.write(toFile: path, atomically: true) {
                                    print("更新 JWT Token 成功")
                                }
                                
                                // 頁面轉跳
                                self.ancestorUID = Int(rrr["Message"] as! String) ?? -1
                                DispatchQueue.main.async {
                                    self.performSegue(withIdentifier: "InvitedIn", sender: self)
                                }
                            }
                            else{
                                // 清空 JWT Token
                                plist["JWT_token"] = ""
                                if plist.write(toFile: path, atomically: true) {
                                    print("清空 JWT Token 成功")
                                }
                                
                                // 清除所有欄位
                                DispatchQueue.main.async {
                                    self.trialPwd.text = ""
                                }
                                
                                // 秀登入失敗
                                DispatchQueue.main.async {
                                    let alertBox = UIAlertController(title: "Error", message: "Login failed.", preferredStyle: .alert)
                                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                                    alertBox.addAction(okAction)
                                    self.show(alertBox, sender: self)
                                }
                            }
                            
                            // print("$\(plist["JWT_token"]as! String)$")
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dst = segue.destination as? ChatTimerViewController{
            dst.UID = ancestorUID
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
