//
//  LoginViewController.swift
//  IssueHub
//
//  Created by 王明海 on 2018/8/11.
//  Copyright © 2018 HeminWon. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        
        let titleLabel = UILabel()
        titleLabel.text = "ISSUES"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 33)
        titleLabel.sizeToFit()
        titleLabel.center = CGPoint(x: 130, y: 110)
        self.view.addSubview(titleLabel)
        
        let detailLabel = UILabel()
        detailLabel.text = "SAMPLE DASHBOARD"
        detailLabel.textColor = UIColor.white
        detailLabel.font = UIFont.systemFont(ofSize: 17)
        detailLabel.sizeToFit()
        detailLabel.frame = CGRect(x: titleLabel.frame.origin.x,
                                   y: titleLabel.frame.origin.y + titleLabel.frame.size.height + 10,
                                   width: detailLabel.frame.size.width,
                                   height: detailLabel.frame.size.height)
        self.view.addSubview(detailLabel)
        
        
    }
}
