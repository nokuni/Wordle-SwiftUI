//
//  BundleExtension.swift
//  Wordle
//
//  Created by Maertens Yann-Christophe on 04/04/22.
//

import Foundation

extension Bundle {
    func words(_ filename: String) -> Set<String> {
        guard let url = url(forResource: filename, withExtension: nil) else {
            return []
        }
        guard let contents = try? String(contentsOf: url) else { return [] }
        
        return Set(contents.components(separatedBy: "\n"))
    }
}
