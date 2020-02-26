//
//  ArrayIndexTrieTests.swift
//  CityListTests
//
//  Created by Elano on 25/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import XCTest
@testable import CityList

class ArrayIndexTrieTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInsert() {
        let array = [MockIndexable("abc"), MockIndexable("bcd"), MockIndexable("bcda")]
        let trie = ArrayIndexTrie()
        let expectation = self.expectation(description: "insert")
        
        trie.insert(sortedArray: array) {
            
            XCTAssertEqual(trie.index(for: "A"), 0)
            XCTAssertEqual(trie.index(for: "a"), 0)
            XCTAssertEqual(trie.index(for: "ab"), 0)
            XCTAssertEqual(trie.index(for: "abc"), 0)
            XCTAssertEqual(trie.index(for: "b"), 1)
            XCTAssertEqual(trie.index(for: "bc"), 1)
            XCTAssertEqual(trie.index(for: "bcd"), 1)
            XCTAssertEqual(trie.index(for: "bcda"), 2)
            XCTAssertEqual(trie.index(for: "bcDa"), 2)
            XCTAssertEqual(trie.index(for: "bcdaa"), ArrayIndexTrie.IndexNotFound)
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }

    

}
