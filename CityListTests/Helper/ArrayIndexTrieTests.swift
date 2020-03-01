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

    func testInsert() {
        let array = sortedArray(["abc", "bcd", "bcda"])
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
    
    func testStartEndIndexes() {
        let array = sortedArray(["abc", "abcd", "bc", "bcd", "bcda", "c", "cd", "ce"])
        let trie = ArrayIndexTrie()
        let expectation = self.expectation(description: "insert")
        
        trie.insert(sortedArray: array) {
            
            let indexesA = trie.indexes(for: "a")
            let indexesB = trie.indexes(for: "Bc")
            let indexesC = trie.indexes(for: "cd")
            let indexesD = trie.indexes(for: "ced")
            
            XCTAssertEqual(indexesA.start, 0)
            XCTAssertEqual(indexesA.end, 1)
            XCTAssertEqual(indexesB.start, 2)
            XCTAssertEqual(indexesB.end, 4)
            XCTAssertEqual(indexesC.start, 6)
            XCTAssertEqual(indexesC.end, 6)
            XCTAssertEqual(indexesD.start, ArrayIndexTrie.IndexNotFound)
            XCTAssertEqual(indexesD.end, ArrayIndexTrie.IndexNotFound)
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
    }
    
    
    func sortedArray(_ values: [String]) -> [MockIndexable] {
        return values.map({ MockIndexable($0) }).sorted()
    }
}
