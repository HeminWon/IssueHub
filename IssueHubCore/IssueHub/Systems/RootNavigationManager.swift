//
//  RootNavigationManager.swift
//  IssueHub
//
//  Created by 王明海 on 2018/9/9.
//  Copyright © 2018 HeminWon. All rights reserved.
//

import UIKit
import GitHubAPI
import GitHubSession

final class RootNavigationManager: GitHubSessionListener {
    
    private let sessionManager: GitHubSessionManager
    weak private var window: UIWindow?
    
    init(sessionManager: GitHubSessionManager,
         window: UIWindow) {
        self.sessionManager = sessionManager
        self.window = window
        self.sessionManager.addListener(listener: self)
    }
    
    public func resetRootViewController(userSession: GitHubUserSession?) {
        guard userSession != nil else {
            
            let loginVC = newLoginViewController()
            
            //设置root
            weak var weakSelf = self
            loginVC.loginCallback = { () -> () in
                let rVC = ViewController()
                weakSelf?.window!.rootViewController = rVC
                weakSelf?.window!.makeKeyAndVisible()
            }
            
            self.window!.rootViewController = loginVC
            self.window!.makeKeyAndVisible()
            
            return
        }
        
        let rVC = ViewController()
        rVC.sessionManager = self.sessionManager
        self.window!.rootViewController = rVC
        self.window!.makeKeyAndVisible()
    }
    

    // MARK: GitHubSessionListener
    func didReceiveRedirect(manager: GitHubSessionManager, code: String) {
        //
    }
    
    func didFocus(manager: GitHubSessionManager, userSession: GitHubUserSession, dismiss: Bool) {
        //
    }
    
    func didLogout(manager: GitHubSessionManager) {
        self.resetRootViewController(userSession: self.sessionManager.focusedUserSession)
    }
    

    private func newLoginViewController() -> LoginViewController {
        let loginVC = LoginViewController()
        loginVC.config(
            client: newGithubClient().client,
            sessionManager: sessionManager)
        return loginVC
    }
    
}
