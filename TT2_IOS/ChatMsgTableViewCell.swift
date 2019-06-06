//
//  ChatMsgTableViewCell.swift
//  TT2_IOS
//
//  Created by KaiHao  on 2019/6/6.
//  Copyright © 2019 NTUST. All rights reserved.
//

import UIKit

class ChatMsgTableViewCell: UITableViewCell {

    let msgLabel = UILabel()
    let bgView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(bgView)
        bgView.backgroundColor = .yellow
        bgView.layer.cornerRadius = 8
        bgView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(msgLabel)
        //msgLabel.backgroundColor = .green
        //msgLabel.text = "HHHHH HHHHH HHHHH HHHHH HHHHH"
        msgLabel.numberOfLines = 0
        msgLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // set constraints
        //msgLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let constraints = [msgLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32),
                           msgLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
                           msgLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
                           //msgLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
                           msgLabel.widthAnchor.constraint(equalToConstant: 220),
                           
                           bgView.topAnchor.constraint(equalTo: msgLabel.topAnchor, constant: -16),
                           bgView.leadingAnchor.constraint(equalTo: msgLabel.leadingAnchor, constant: -16),
                           bgView.bottomAnchor.constraint(equalTo: msgLabel.bottomAnchor, constant: 16),
                           bgView.trailingAnchor.constraint(equalTo: msgLabel.trailingAnchor, constant: 16)]
        
        NSLayoutConstraint.activate(constraints) 
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
     */
}
