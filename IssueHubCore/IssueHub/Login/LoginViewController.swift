//
//  LoginViewController.swift
//  IssueHub
//
//  Created by 王明海 on 2018/8/11.
//  Copyright © 2018 HeminWon. All rights reserved.
//

import UIKit
import AuthenticationServices
import GitHubAPI
import GitHubSession
import TransitionButton

private let callbackURLScheme = "issuehub://auth"
private let loginURL = URL(string: "https://github.com/login/oauth/authorize?client_id=\(Secrets.GitHub.clientId)&scope=user+repo+notifications")!

class LoginViewController: UIViewController, GitHubSessionListener {

    typealias callback = () -> ()
    var loginCallback : callback?
    
    private var client: Client!
    private var sessionManager: GitHubSessionManager!
    
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
    
    private var transition: TransitionButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        self.setupUI()
        
        self.sessionManager?.addListener(listener: self as GitHubSessionListener)
    }
    
    // MARK: Public API
    func config(client: Client, sessionManager: GitHubSessionManager) {
        self.client = client
        self.sessionManager = sessionManager
    }
    
    private func setupUI() {
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
        
        transition = TransitionButton()
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
            self.sessionManager?.receivedCodeRedirect(url: callbackUrl)
          
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
    
    private func finishLogin(token: String, authMethod: GitHubUserSession.AuthMethod, username: String) {
        sessionManager.focus(
            GitHubUserSession(token: token, authMethod: authMethod, username: username),
            dismiss: true
        )
    }
    
    func didReceiveRedirect(manager: GitHubSessionManager, code: String) {
        transition.startAnimation()
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async(execute: {
            
            self.client.requestAccessToken(code: code) { [weak self] result in
                switch result {
                case .error:
                    self?.handleError()
                case .success(let user):
                    self?.finishLogin(token: user.token, authMethod: .oauth, username: user.username)
                    DispatchQueue.main.async(execute: { () -> Void in
                        weak var weakSelf = self
                        self?.transition.stopAnimation(animationStyle: .expand, revertAfterDelay: TimeInterval(MAXFLOAT), completion: {
                            if (weakSelf?.loginCallback != nil) {
                                weakSelf?.loginCallback!()
                            }
                        })
                    })
                }
            }
        })
    }
    
    func didFocus(manager: GitHubSessionManager, userSession: GitHubUserSession, dismiss: Bool) {
        //
    }
    
    func didLogout(manager: GitHubSessionManager) {
        //
    }
    
    deinit {
        print(" login view had been destoryed ")
    }
}
