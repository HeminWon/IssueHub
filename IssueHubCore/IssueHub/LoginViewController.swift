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
        
        let transition = TransitionButton()
        transition.frame = CGRect(x: 0.0, y: 0.0, width: 300.0, height: 50.0)
        transition.center = CGPoint(x: self.view.centerX, y: self.view.bottom - transition.height - 80.0)
        transition.cornerRadius = transition.height * 0.5
        transition.setTitle("Sign in with Github", for: .normal)
        transition.backgroundColor = UIColor.red
        transition.addTarget(self, action: #selector(transitionAction(_:)), for: .touchUpInside)
        self.view.addSubview(transition)
    }
    
    @objc func transitionAction(_ btn: TransitionButton) {
        btn.startAnimation()
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async(execute: {
            
            sleep(3) // 3: Do your networking task or background work here.
            
            DispatchQueue.main.async(execute: { () -> Void in
                btn.stopAnimation(animationStyle: .expand, revertAfterDelay: TimeInterval(MAXFLOAT), completion: {
                    //
                })
            })
        })
    }
}
