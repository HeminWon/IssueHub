//
//  Secrets.swift
//  IssueHub
//
//  Created by 王明海 on 2018/8/12.
//  Copyright © 2018 HeminWon. All rights reserved.
//

import UIKit

enum Secrets {
    
    enum CI {
        static let githubId = "{GITHUBID}"
        static let githubSecret = "{GITHUBSECRET}"
        static let imgurId = "{IMGURID}"
    }
    
    enum GitHub {
        static let clientId = Secrets.environmentVariable(named: "GITHUB_CLIENT_ID") ?? CI.githubId
        static let clientSecret = Secrets.environmentVariable(named: "GITHUB_CLIENT_SECRET") ?? CI.githubSecret
    }
    
    enum Imgur {
        static let clientId = Secrets.environmentVariable(named: "IMGUR_CLIENT_ID") ?? CI.imgurId
    }
    
    fileprivate static func environmentVariable(named: String) -> String? {
        let processInfo = ProcessInfo.processInfo
        guard let value = processInfo.environment[named] else {
            print("‼️ Missing Environment Variable: '\(named)'")
            return nil
        }
        return value
   }
}
