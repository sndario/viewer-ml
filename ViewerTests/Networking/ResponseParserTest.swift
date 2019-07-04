//
//  ResponseParserTest.swift
//  ViewerTests
//
//  Created by Dario Suarez on 30/06/2019.
//  Copyright © 2019 Dario Suarez. All rights reserved.
//

@testable import Viewer
import XCTest

class ResponseParserTest: XCTestCase {

    var parser: ResponseParser!
    
    override func setUp() {
        super.setUp()
        parser = ResponseParser()
    }

    override func tearDown() {
        parser = nil
        super.tearDown()
    }

    func testParserSuccess() {
        let data = TestUtils.loadJson("success_response")
        parser.decode(data: data!,
                      decodingType: SearchResult.self,
                      completion: { (obj) in
                        XCTAssertEqual(obj.siteId, "MLA")
                        XCTAssertEqual(obj.query, "ipod")
                        XCTAssertNil(obj.results)
        }) { (err) in
            XCTFail()
        }
    }

    func testParserFailure() {
        let data = TestUtils.loadJson("failure_response")
        parser.decode(data: data!,
                      decodingType: SearchResult.self,
                      completion: { (obj) in
                        XCTFail()
        }) { (err) in
            XCTAssertTrue(err.code == ErrorCode.parserError.rawValue)
        }
    }
}

class TestUtils {
    static func loadJson(_ json: String) -> Data? {
        guard let path = Bundle(for: TestUtils.self).path(forResource: json,
                                                          ofType: "json") else { return nil }
        return try? Data(contentsOf: URL(fileURLWithPath: path))
    }
}
