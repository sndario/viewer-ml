//
//  ViewerError.swift
//  Viewer
//
//  Created by Dario Suarez on 29/06/2019.
//  Copyright © 2019 Dario Suarez. All rights reserved.
//

import Foundation

enum ErrorCode: Int {
    case defaultError = 100
    case noInternetconnecton
    case unauthorized
    case serverError
    case connectionTimeOut
    case parserError
    case wrongStatusCode
}

enum ViewerError: Error {
    
    case defaultError(code: Int, userInfo: [String: AnyObject]?)
    case noInternetConnection(code: Int, userInfo: [String: AnyObject]?)
    case connectionTimeOut(code: Int, userInfo: [String: AnyObject]?)
    case unauthorized(code: Int, userInfo: [String: AnyObject]?)
    case serverError(dcode: Int, userInfo: [String: AnyObject]?)
    case parserError(code: Int, userInfo: [String: AnyObject]?)
    case wrongStatusCode(code: Int, userInfo: [String: AnyObject]?)
    
    var code: Int {
        switch self {
        case .defaultError(let code, _):
            return code
        case .noInternetConnection(let code, _):
            return code
        case .unauthorized(let code, _):
            return code
        case .serverError(let code, _):
            return code
        case .connectionTimeOut(let code, _):
            return code
        case .parserError(let code, _):
            return code
        case .wrongStatusCode(let code, _):
            return code
        }
    }
    
    init(_ fromUrlError: Error) {
        guard let urlError = fromUrlError as? URLError else { self = .defaultError(code: -1,
                                                                                   userInfo: nil); return}
        switch urlError.code {
        case URLError.networkConnectionLost:
            // error network
            debugPrint("Network connection lost: " + urlError.localizedDescription)
            self = .noInternetConnection(code: URLError.networkConnectionLost.rawValue,
                                         userInfo: [NSLocalizedFailureReasonErrorKey: "CONNETION_ERROR" as AnyObject])
        case URLError.notConnectedToInternet:
            // no internet
            debugPrint("No internet connection: " + urlError.localizedDescription)
            self = .noInternetConnection(code: URLError.notConnectedToInternet.rawValue,
                                         userInfo: [NSLocalizedFailureReasonErrorKey: "CONNETION_ERROR" as AnyObject])
        case URLError.timedOut:
            // timeout
            debugPrint("Network timeout: " + urlError.localizedDescription)
            self = .connectionTimeOut(code: URLError.timedOut.rawValue,
                                      userInfo: [NSLocalizedFailureReasonErrorKey: "TIMEOUT_ERROR" as AnyObject])
        default:
            debugPrint("Networking error: " + urlError.localizedDescription)
            self = .defaultError(code: -1, userInfo: nil)
        }
    }
}
