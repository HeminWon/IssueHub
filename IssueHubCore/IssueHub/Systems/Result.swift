//
//  Result.swift
//  IssueHub
//
//  Created by 王明海 on 2018/9/9.
//  Copyright © 2018 HeminWon. All rights reserved.
//

import Foundation

enum Result<T> {
    case error(Error?)
    case success(T)
}
