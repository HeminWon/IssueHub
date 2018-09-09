//
//  Alamofire+GithubAPI.swift
//  IssueHub
//
//  Created by 王明海 on 2018/9/9.
//  Copyright © 2018 HeminWon. All rights reserved.
//

import Foundation
import Alamofire
import Apollo
import GitHubSession
import GitHubAPI

func newGithubClient(
    userSession: GitHubUserSession? = nil
    ) -> GithubClient {
    let networkingConfigs = userSession?.networkingConfigs
    let config = ConfiguredNetworkers(
        token: networkingConfigs?.token,
        useOauth: networkingConfigs?.useOauth
    )
    return GithubClient(
        apollo: config.apollo,
        networker: config.alamofire,
        userSession: userSession
    )
}
