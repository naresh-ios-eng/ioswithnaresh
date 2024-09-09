//
//  StatusCode.swift
//  ProductViewer
//
//  Created by Naresh on 08/09/2024
//

import Foundation

/// Here we will define the status code as per the server configuration, like 200 for success, 401 for unauthorised access. You may ask your backend team and update the code if required.
public enum StatusCode: Int {
    /// When api succeed then we will get 200 status code.
    case success = 200
    /// When we try to reach the url that doesn't exist in that case the 403 would be returned.
    case badRequest = 403
    /// Server is not working or some other error at server end.
    case serverError = 503
    /// If the authorization token expired.
    case authoriztionFailed = 401
}
