//
//  GithubClient.swift
//  IssueHub
//
//  Created by 王明海 on 2018/9/9.
//  Copyright © 2018 HeminWon. All rights reserved.
//

import Foundation
import Alamofire
import Apollo
import FlatCache
import GitHubAPI
import GitHubSession

struct GithubClient {
    
    let userSession: GitHubUserSession?
    let cache = FlatCache()
    let bookmarksStore: BookmarkStore?
    let client: Client
    
    init(
        apollo: ApolloClient,
        networker: Alamofire.SessionManager,
        userSession: GitHubUserSession? = nil
        ) {
        self.userSession = userSession
        
        self.client = Client(httpPerformer: networker, apollo: apollo, token: userSession?.token)
        
        if let token = userSession?.token {
            self.bookmarksStore = BookmarkStore(token: token)
        } else {
            self.bookmarksStore = nil
        }
    }
}
