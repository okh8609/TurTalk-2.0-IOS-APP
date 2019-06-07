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
        print("\(effTime[0]):\(effTime[1]):\(effTime[2]).000")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*
        if let dst = segue.destination as? ChatTimerViewController{
            //dst.UID = (ChatList[indexPath.row]["uid"] as! Int)
            dst.UID = (ChatList[(tableView.indexPathForSelectedRow?.row)!]["uid"] as! Int)
            tableView.deselectRow(at: (tableView.indexPathForSelectedRow)!, animated: true)
        }
 */
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
