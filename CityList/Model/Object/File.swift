//
//  File.swift
//  CityList
//
//  Created by Elano on 26/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

class File<T: Decodable>: NSObject {

    let name: String
    let type: String
    
    init(name: String, type: String = "json") {
        self.name = name
        self.type = type
    }
    
    func get(completionHandler: @escaping (Result<T,FileError>) -> Void) {
        
        ThreadHelper.background { [name, type] in
            guard
                let path = Bundle.main.path(forResource: name, ofType: type),
                let url = URL(string: "file://" + path)
            else {
                completionHandler(.failure(.path))
                return
            }
            
            do {
                let jsonData = try Data(contentsOf: url)
                let values = try JSONDecoder().decode(T.self, from: jsonData)
                
                completionHandler(.success(values))
            } catch {
                print("[File|get]: \(error.localizedDescription)")
                completionHandler(.failure(.decoder))
            }
        }
    } 
}

enum FileError: Error {
    case path
    case decoder
    case data
}
