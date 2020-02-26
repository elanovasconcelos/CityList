//
//  ThreadHelper.swift
//  CityList
//
//  Created by Elano on 26/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import UIKit

final class ThreadHelper: NSObject {
    
    static func background(function: @escaping () -> Void)
    {
        DispatchQueue.global().async(execute: function)
    }
    
    static func main(function: @escaping () -> Void)
    {
        DispatchQueue.main.async(execute: function)
    }
}
