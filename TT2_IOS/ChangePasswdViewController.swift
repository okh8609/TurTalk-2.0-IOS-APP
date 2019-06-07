//
//  ChangePasswdViewController.swift
//  TT2_IOS
//
//  Created by KaiHao  on 2019/5/24.
//  Copyright © 2019 NTUST. All rights reserved.
//

import UIKit

class ChangePasswdViewController: UIViewController {

    @IBOutlet weak var passwd0: UITextField!
    @IBOutlet weak var passwd1: UITextField!
    @IBOutlet weak var passwd2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.3) {
            self.view.endEditing(true)
        }
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
                if let JWT_token = plist["JWT_token"] { // 取得jwt token
                    
                    //要送出的資料
                    let json: [String: Any] = ["oldPasswd" : passwd0.text ?? "",
                                               "newPasswd" : passwd1.text ?? ""]
                    let jsonData = try? JSONSerialization.data(withJSONObject: json)
                    
                    //指定api的url
                    let url = URL(string: ((API_URL as! String) + "api/account/change/passwd"))
                    
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
                            // print(rrr!)
                            if(rrr == "true")
                            {
                                // 秀出修改成功
                                DispatchQueue.main.async {
                                    let alert = UIAlertController(title: "Success", message: "Password changed successfully.", preferredStyle: .alert)
                                    let OKAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(_)in self.performSegue(withIdentifier: "unwindToProfile01", sender: self)})
                                    alert.addAction(OKAction)
                                    self.present(alert, animated: true, completion: nil)
                                }
                            }
                            else
                            {
                                // 清除所有欄位
                                DispatchQueue.main.async {
                                    self.passwd0.text = ""
                                    self.passwd1.text = ""
                                    self.passwd2.text = ""
                                }
                                
                                // 秀出修改失敗
                                DispatchQueue.main.async {
                                    let alertBox = UIAlertController(title: "Error", message: "Password change failed.", preferredStyle: .alert)
                                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                                    alertBox.addAction(okAction)
                                    self.present(alertBox, animated: true, completion: nil)
                                }
                            }
                        }
                    }
                    
                    // 開始讀取資料
                    dataTask.resume()
                }
            }
        }
    }
    
    
    
    func showMsg(msg: String, foo: (() -> ())?)
    {
        DispatchQueue.main.async {
            
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
              self.present(alertBox, animated: true, completion: nil)
            
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
