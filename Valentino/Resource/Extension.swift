//
//  Extension.swift
//  Valentino
//
//  Created by Liu John on 2022-03-15.
//

import Foundation

extension String {
    func safeDatabaseKey() -> String {
    
        return self.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")
    }
}
