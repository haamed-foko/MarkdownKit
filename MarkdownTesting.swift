//
//  MarkdownTesting.swift
//  MarkdownKit
//
//  Created by Haamed Sultani on 2020-05-28.
//  Copyright © 2020 Ivan Bruel. All rights reserved.
//

import XCTest

class MarkdownTesting: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func testCodeParsing() {
        let content = """
                ```
                test
                ```
            """
        
        self.measure {
            
        }
    }
}
