//
//  ViewController.swift
//  IssueHub
//
//  Created by HeminWon on 2018/8/7.
//  Copyright © 2018 HeminWon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let btn = UIButton(type:.custom)
        btn.frame = CGRect(x: 50, y: 100, width: 300, height: 100)
        btn.setTitle("普通状态", for: .normal)
        btn.backgroundColor = UIColor.red
        btn.addTarget(self, action:#selector(btnAction(btn:)), for: .touchUpInside)
        self.view.addSubview(btn)
        
    }

    @objc func btnAction(btn: UIButton) {
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .formSheet
        
        self.present(loginVC, animated: true, completion: nil)
    }

}

