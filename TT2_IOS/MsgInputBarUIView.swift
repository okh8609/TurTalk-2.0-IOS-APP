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
    var textBox = UITextField()
    var sendBtn = UIButton(type: .system)
    
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
        
        self.backgroundColor = UIColor.white
        
        let topBorderView = UIView()
        topBorderView.backgroundColor = UIColor.init(white: 0.5, alpha: 0.5)
        topBorderView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(topBorderView)
        topBorderView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        topBorderView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        topBorderView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        topBorderView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        textBox.placeholder = "Enter message..."
        textBox.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textBox)
        textBox.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        textBox.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -60).isActive = true
        textBox.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        textBox.topAnchor.constraint(equalTo: self.topAnchor, constant: 0.5).isActive = true
        
        sendBtn.setTitle("Send", for: .normal)
        let cc = UIColor(red: 0, green: 137/255, blue: 249/255, alpha: 1)
        sendBtn.setTitleColor(cc, for: .normal)
        sendBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        sendBtn.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(sendBtn)
        sendBtn.widthAnchor.constraint(equalToConstant: 60).isActive = true
        sendBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        sendBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        sendBtn.topAnchor.constraint(equalTo: self.topAnchor, constant: 0.5).isActive = true
        
    }
    
}
