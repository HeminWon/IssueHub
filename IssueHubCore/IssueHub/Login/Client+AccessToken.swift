//
//  Client+AccessToken.swift
//  IssueHub
//
//  Created by 王明海 on 2018/9/9.
//  Copyright © 2018 HeminWon. All rights reserved.
//

import Foundation
import GitHubAPI

extension Client {
    
    struct AccessTokenUser {
        let token: String
        let username: String
    }
    
    func requestAccessToken(
        code: String,
        completion: @escaping (Result<AccessTokenUser>) -> Void
        ) {
        send(GitHubAccessTokenRequest(
            code: code,
            clientId: Secrets.GitHub.clientId,
            clientSecret: Secrets.GitHub.clientSecret)
        ) { [weak self] result in
            switch result {
            case .success(let response):
                self?.send(V3VerifyPersonalAccessTokenRequest(token: response.data.accessToken)) { result in
                    switch result {
                    case .success(let response2):
                        completion(.success(AccessTokenUser(token: response.data.accessToken, username: response2.data.login)))
                    case .failure(let error):
                        completion(.error(error))
                    }
                }
            case .failure(let error):
                completion(.error(error))
            }
        }
    }
    
}
