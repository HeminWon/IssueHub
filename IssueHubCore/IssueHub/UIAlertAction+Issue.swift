//
//  UIAlertAction+Issue.swift
//  IssueHub
//
//  Created by 王明海 on 2018/8/12.
//  Copyright © 2018 HeminWon. All rights reserved.
//

import UIKit

extension UIAlertAction {
    static func cancel(handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertAction {
        return UIAlertAction(title: "Cancel", style: .cancel, handler: handler)
    }
    
    static func ok(handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertAction {
        return UIAlertAction(title: "Ok", style: .default, handler: handler)
    }
}
