//
//  LoginViewController.swift
//  IssueHub
//
//  Created by 王明海 on 2018/8/11.
//  Copyright © 2018 HeminWon. All rights reserved.
//

import UIKit
import AuthenticationServices

private let callbackURLScheme = "issuehub://auth"
private let loginURL = URL(string: "https://github.com/login/oauth/authorize?client_id=\(Secrets.GitHub.clientId)&scope=user+repo+notifications")!

class LoginViewController: UIViewController {

    typealias callback = () -> ()
    var loginCallback : callback?
    
    @available(iOS 12.0, *)
    private var authSession: ASWebAuthenticationSession? {
        get {
            return _authSession as? ASWebAuthenticationSession
        }
        set {
            _authSession = newValue
        }
    }
    private var _authSession: Any?
    
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
        
        self.authSession = ASWebAuthenticationSession(url: loginURL, callbackURLScheme: callbackURLScheme, completionHandler: {(callbackUrl, error) in
            guard error == nil, let callbackUrl = callbackUrl else {
                switch error! {
                case ASWebAuthenticationSessionError.canceledLogin:
                    break
                default:
                    self.handleError()
                }
                return
            }
            print(callbackUrl)
            
            btn.startAnimation()
            let qualityOfServiceClass = DispatchQoS.QoSClass.background
            let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
            backgroundQueue.async(execute: {
                
                sleep(3) // 3: Do your networking task or background work here.
                DispatchQueue.main.async(execute: { () -> Void in
                    weak var weakSelf = self
                    btn.stopAnimation(animationStyle: .expand, revertAfterDelay: TimeInterval(MAXFLOAT), completion: {
                        if (weakSelf?.loginCallback != nil) {
                            weakSelf?.loginCallback!()
                        }
                    })
                })
            })
        })
        self.authSession?.start()
        
    }
    
    private func handleError() {
        
        let alert = UIAlertController(
            title: NSLocalizedString("Error", comment: ""),
            message: NSLocalizedString("There was an error signing in to GitHub. Please try again.", comment: ""),
            preferredStyle: .alert
        )
//        let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
//        })
        alert.addAction(.ok())
        present(alert, animated: true)
    }
    
    deinit {
        print(" login view had been destoryed ")
    }
}
