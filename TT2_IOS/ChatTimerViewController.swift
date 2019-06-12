//
//  ChatTimerViewController.swift
//  TT2_IOS
//
//  Created by KaiHao  on 2019/6/4.
//  Copyright © 2019 NTUST. All rights reserved.
//

import UIKit

class ChatTimerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{

    var UID: Int?
    
    let HH = Array(0...23)
    let MM = Array(0...59)
    let SS = Array(0...59)
    var effTime = [Int](repeating:0, count: 3) // HH:MM:SS
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(UID!)
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // 0 代表最左邊的滾輪
        
        if component == 0 {
            return HH.count
        }
        else if component == 1 {
            return MM.count
        }
        else if component == 2 {
            return SS.count
        }
        
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
            return String(HH[row])
        }
        else if component == 1 {
            return String(MM[row])
        }
        else if component == 2 {
            return String(SS[row])
        }
        
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 0 {
            // print("HH：\(HH[row])")
            effTime[0] = HH[row]
        }
        else if component == 1 {
            // print("MM：\(MM[row])")
            effTime[1] = MM[row]
        }
        else if component == 2 {
            // print("SS：\(SS[row])")
            effTime[2] = SS[row]
        }
        //print("\(effTime[0]):\(effTime[1]):\(effTime[2]).000")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dst = segue.destination as? ChatMsgViewController{
            dst.UID = self.UID
            dst.eff_t = "\(effTime[0]):\(effTime[1]):\(effTime[2]).000"
        }
    }
    @IBAction func okBtnClick(_ sender: UIButton) {
        if (((effTime[0] * 60 + effTime[1]) * 60 + effTime[2]) < 5)
        {
            let alertBox = UIAlertController(title: "Error", message: "Message effective time must at least 5 seconds.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertBox.addAction(okAction)
            self.present(alertBox, animated: true, completion: nil)
        }
        else
        {
            performSegue(withIdentifier: "ShowChatMsg", sender: self)
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
