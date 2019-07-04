//
//  NetworkingTest.swift
//  ViewerTests
//
//  Created by Dario Suarez on 30/06/2019.
//  Copyright © 2019 Dario Suarez. All rights reserved.
//

@testable import Viewer
import XCTest

class NetworkingTest: XCTestCase {

    var networking: Networking!
    var sessionMock: URLSessionMock!
    
    override func setUp() {
        super.setUp()
        sessionMock = URLSessionMock()
        networking = Networking(session: sessionMock)
    }

    override func tearDown() {
        super.tearDown()
        networking = nil
        sessionMock = nil
    }

    func testCallSuccess() {
        sessionMock.data = TestUtils.loadJson("success_response")
        sessionMock.response = HTTPURLResponse(url: URL(string: "test.com")!,
                                               statusCode: 200,
                                               httpVersion: nil,
                                               headerFields: nil)
        let requestMock = ServiceMock.getService().urlRequest
        networking.call(urlRequest: requestMock,
                        decodingType: SearchResult.self) { (result) in
                            switch result {
                            case .empty, .failure:
                                XCTFail()
                            case .success(let obj):
                                XCTAssertEqual(obj.siteId, "MLA")
                                XCTAssertEqual(obj.query, "ipod")
                                XCTAssertNil(obj.results)
                            }
        }
    }
    
    func testCallSuccessParserFailure() {
        sessionMock.data = TestUtils.loadJson("failure_response")
        sessionMock.response = HTTPURLResponse(url: URL(string: "test.com")!,
                                               statusCode: 200,
                                               httpVersion: nil,
                                               headerFields: nil)
        sessionMock.error = nil
        let requestMock = ServiceMock.getService().urlRequest
        networking.call(urlRequest: requestMock,
                        decodingType: SearchResult.self) { (result) in
                            switch result {
                            case .empty, .success:
                                XCTFail()
                            case .failure(let error):
                                XCTAssertEqual(error.code, ErrorCode.parserError.rawValue)
                            }
        }
    }
    
    func testCallFailure() {
        sessionMock.data = nil
        sessionMock.error = URLError(.timedOut)
        let requestMock = ServiceMock.getService().urlRequest
        networking.call(urlRequest: requestMock,
                        decodingType: SearchResult.self) { (result) in
                            switch result {
                            case .empty, .success:
                                XCTFail()
                            case .failure(let err):
                                XCTAssertEqual(err.code, URLError.timedOut.rawValue)
                            }
        }
    }
    
    func testCallEmpty() {
        sessionMock.data = nil
        sessionMock.error = nil
        sessionMock.response = HTTPURLResponse(url: URL(string: "test.com")!,
                                               statusCode: 200,
                                               httpVersion: nil,
                                               headerFields: nil)
        let requestMock = ServiceMock.getService().urlRequest
        networking.call(urlRequest: requestMock,
                        decodingType: SearchResult.self) { (result) in
                            switch result {
                            case .failure, .success:
                                XCTFail()
                            case .empty:
                                XCTAssert(true)
                            }
        }
    }
    
    func testCallSuccessWrongStatusCode() {
        sessionMock.data = TestUtils.loadJson("success_response")
        sessionMock.response = HTTPURLResponse(url: URL(string: "test.com")!,
                                               statusCode: 405,
                                               httpVersion: nil,
                                               headerFields: nil)
        let requestMock = ServiceMock.getService().urlRequest
        networking.call(urlRequest: requestMock,
                        decodingType: SearchResult.self) { (result) in
                            switch result {
                            case .empty, .success:
                                XCTFail()
                            case .failure(let error):
                                XCTAssertEqual(error.code, 405)
                            }
        }
    }
    
    func testCallEmptyWrongStatusCode() {
        sessionMock.response = HTTPURLResponse(url: URL(string: "test.com")!,
                                               statusCode: 405,
                                               httpVersion: nil,
                                               headerFields: nil)
        let requestMock = ServiceMock.getService().urlRequest
        networking.call(urlRequest: requestMock,
                        decodingType: SearchResult.self) { (result) in
                            switch result {
                            case .empty, .success:
                                XCTFail()
                            case .failure(let error):
                                XCTAssertEqual(error.code, 405)
                            }
        }
    }

}

enum ServiceMock: Service {
    
    case getService()
    
    var baseURL: String {
        return "test.com"
    }
    
    var path: String {
        return "/get"
    }
    
    var parameters: [String : Any]? {
        return nil
    }
    
    var method: HttpMethod {
        return .get
    }
}

class URLSessionMock: URLSession {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    var data: Data?
    var error: Error?
    var response: URLResponse?
    
    override func dataTask(with request: URLRequest,
                           completionHandler: @escaping CompletionHandler) -> URLSessionDataTask {
        let data = self.data
        let error = self.error
        let response = self.response
        return URLSessionDataTaskMock {
            completionHandler(data, response, error)
        }
    }
}

class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    override func resume() {
        closure()
    }
}
