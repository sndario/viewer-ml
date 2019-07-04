//
//  Parser.swift
//  Viewer
//
//  Created by Dario Suarez on 17/06/2019.
//  Copyright © 2019 Dario Suarez. All rights reserved.
//

import Foundation

protocol ResponseParserProtocol {
    func decode<T:Decodable>(data: Data,
                             decodingType: T.Type,
                             completion: (_ result: T)->Void,
                             failure: (_ error: ViewerError)->Void)
}

class ResponseParser: ResponseParserProtocol {
    func decode<T:Decodable>(data: Data,
                             decodingType: T.Type,
                             completion: (_ result: T)->Void,
                             failure: (_ error: ViewerError)->Void) {
        do {
            let obj = try JSONDecoder().decode(decodingType,
                                               from: data)
            completion(obj)
        } catch {
            failure(ViewerError.parserError(code: 105,
                                            userInfo: [NSLocalizedFailureReasonErrorKey: error.localizedDescription as AnyObject]))
        }
    }
}
