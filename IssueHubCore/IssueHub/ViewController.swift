//
//  ViewController.swift
//  IssueHub
//
//  Created by HeminWon on 2018/8/7.
//  Copyright © 2018 HeminWon. All rights reserved.
//

import UIKit
import GitHubSession

class ViewController: UIViewController {

    // must be injected
    var sessionManager = GitHubSessionManager.defaultManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let btn = UIButton(type:.custom)
        btn.frame = CGRect(x: 0.0, y: LENGTH_ADAPTER(length: 120.0), width: 300.0, height: 100.0)
        btn.centerX = self.view.centerX
        btn.setTitle("普通状态", for: .normal)
        btn.backgroundColor = UIColor.red
        btn.addTarget(self, action:#selector(btnAction(btn:)), for: .touchUpInside)
        self.view.addSubview(btn)
        
        
        let btn1 = UIButton(type:.custom)
        btn1.frame = CGRect(x: 0.0, y: LENGTH_ADAPTER(length: 240.0), width: 280.0, height: 80.0)
        btn1.centerX = self.view.centerX
        btn1.setTitle("退出登录", for: .normal)
        btn1.backgroundColor = UIColor.red
        btn1.addTarget(self, action:#selector(btn1Action(btn:)), for: .touchUpInside)
        self.view.addSubview(btn1)
        
    }

    @objc func btnAction(btn: UIButton) {
        let loginVC = LoginViewController()
        loginVC.config(client: newGithubClient().client, sessionManager: sessionManager)
        loginVC.modalPresentationStyle = .formSheet
        weak var weakLoginVC = loginVC
        loginVC.loginCallback = { () -> () in
            weakLoginVC?.dismiss(animated: false, completion: nil)
        }
        self.present(loginVC, animated: true, completion: nil)
    }

    @objc func btn1Action(btn: UIButton) {
        //
        sessionManager.logout()
    }
    
    deinit {
        print(" view had been destoryed ")
    }
}

