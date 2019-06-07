//
//  MsgInputBarUIView.swift
//  TT2_IOS
//
//  Created by KaiHao  on 2019/6/6.
//  Copyright © 2019 NTUST. All rights reserved.
//

import UIKit

class MsgInputBarUIView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var textBox: UITextField?
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    private func setupView() {
        // Create, add and layout the children views ..
        
        self.backgroundColor = UIColor.lightGray
        
        textBox = UITextField()
        textBox!.placeholder = "Enter message..."
        textBox!.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textBox!)
        textBox!.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        textBox!.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        textBox!.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        textBox!.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
    }
    
}
