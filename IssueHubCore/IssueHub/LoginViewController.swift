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
        titleLabel.font = UIFont.boldSystemFont(ofSize: 33.0)
        titleLabel.sizeToFit()
        titleLabel.center = CGPoint(x: LENGTH_ADAPTER(length: 130.0), y: LENGTH_ADAPTER(length: 120))
        self.view.addSubview(titleLabel)
        
        let detailLabel = UILabel()
        detailLabel.text = "SAMPLE DASHBOARD"
        detailLabel.textColor = UIColor.white
        detailLabel.font = UIFont.systemFont(ofSize: 17.0)
        detailLabel.sizeToFit()
        detailLabel.frame = CGRect(x: titleLabel.left,
                                   y: titleLabel.bottom + 10.0,
                                   width: detailLabel.width,
                                   height: detailLabel.height)
        self.view.addSubview(detailLabel)
        
        
    }
}
