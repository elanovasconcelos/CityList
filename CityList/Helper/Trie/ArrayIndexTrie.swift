//
//  ArrayIndexTrie.swift
//  CityList
//
//  Created by Elano on 25/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit


typealias NodeIndex = (start: Int, end: Int)

final class ArrayIndexTrie: NSObject {
    static let IndexNotFound = -1
    
    private let root: Node
    private lazy var queue = DispatchQueue(label: "com.elano.ArrayIndexTrie")
    
    override init() {
        root = Node(value: Character(" "), index: 0, endIndex: 0)
    }
    
    /// Insert all the keys of the Indexable protocol in the Trie asynchronously . All previous values will be lost.
    /// - Parameter sortedArray: A sorted arry of string
    /// - Parameter completionHandler: Called after finish inserting the array
    func insert(sortedArray: [Indexable], completionHandler: @escaping () -> Void) {
        queue.async { [weak self] in
            var index = 0
            
            self?.reset()

            for value in sortedArray {
                self?.insert(word: value.key, at: index)
                index += 1
            }
            
            if !sortedArray.isEmpty {
                self?.root.endIndex = index - 1
            }
            
            completionHandler()
        }
    }
    
    /// Returns the start and end indexes of the sorted array.
    /// - Parameter word: A string prefix to be searched in the trie
    func index(for word: String) -> Int {
        return indexes(for: word).start
    }
    
    /// Returns the start and end indexes of the sorted array.
    /// The start index is the first index of the array with the prefix.
    /// The end index is the last index of the array with the prefix.
    /// - Parameter word: A string prefix to be searched in the trie
    func indexes(for word: String) -> NodeIndex {
        if word.isEmpty {
            return root.indexes
        }
        
        var currentNode = root
        for character in word.lowercased() {
            if let node = currentNode.children[character] {
                currentNode = node
            }else {
                return (start: ArrayIndexTrie.IndexNotFound, end: ArrayIndexTrie.IndexNotFound)
            }
        }
        
        return currentNode.indexes
    }
    
    func reset() {
        root.children.removeAll()
    }
    
    private func insert(word: String, at index: Int) {
        var currentNode = root
        
        for character in word.lowercased() {
          if let childNode = currentNode.children[character] {
            currentNode = childNode
            currentNode.endIndex = index
          } else {
            currentNode.add(value: character, index: index)
            currentNode = currentNode.children[character]!
          }
        }
    }
}

//MARK: - Node
extension ArrayIndexTrie {
    final class Node {
        let value: Character
        lazy var children = [Character: Node]()
        let index: Int
        var endIndex: Int
        
        init(value: Character, index: Int, endIndex: Int) {
            self.value = value
            self.index = index
            self.endIndex = endIndex
            
            //print("node: \(value), index: \(index)")
        }
        
        func add(value: Character, index: Int) {
            if children[value] != nil {
                return
            }
            
            children[value] = Node(value: value, index: index, endIndex: index)
        }
        
        var indexes: NodeIndex {
            return (start: index, end: endIndex)
        }
    }
}
