//
//  ChangeNameViewController.swift
//  TT2_IOS
//
//  Created by KaiHao  on 2019/5/24.
//  Copyright © 2019 NTUST. All rights reserved.
//

import UIKit

class ChangeNameViewController: UIViewController {

    @IBOutlet weak var newName: UITextField!
    
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
        
        if(newName.text == nil || newName.text == "")
        {

            let alertBox = UIAlertController(title: "Error", message: "Username can not be empty.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertBox.addAction(okAction)
            self.present(alertBox, animated: true, completion: nil)

            return;
        }
        
        let path = NSHomeDirectory() + "/Documents/Helper.plist"
        if let plist = NSMutableDictionary(contentsOfFile: path) {
            if let API_URL = plist["API_URL"] {
                if let JWT_token = plist["JWT_token"] { // 取得jwt token
                   
                    //指定api的url
                    let url = URL(string: ((API_URL as! String) + "api/account/change/name"))
                    
                    var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 30)
                    request.setValue(("Bearer " + (JWT_token as! String)), forHTTPHeaderField: "Authorization")
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.httpBody = "\"\(newName.text!)\"".data(using: .utf8)
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
                                    let alert = UIAlertController(title: "Success", message: "Username changed successfully.", preferredStyle: .alert)
                                    let OKAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(_)in self.performSegue(withIdentifier: "unwindToProfile02", sender: self)})
                                    alert.addAction(OKAction)
                                    self.present(alert, animated: true, completion: nil)
                                }
                            }
                            else
                            {
                                // 秀出修改失敗
                                DispatchQueue.main.async {
                                    let alertBox = UIAlertController(title: "Error", message: "Username change failed.", preferredStyle: .alert)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
