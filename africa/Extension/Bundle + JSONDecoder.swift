//
//  Bundle + Codable.swift
//  africa
//
//  Created by paigeshin on 2021/02/13.
//

import Foundation

extension Bundle {
    
    func decode<T: Codable>(_ fileName: String) -> T {
        
        // 1. Locate the json file
        guard let url: URL = self.url(forResource: fileName, withExtension: nil) else {
            fatalError("Failed to locate \(fileName) in bundle")
        }
        
        // 2. Create a property for the data
        guard let data: Data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(fileName) from bundle.")
        }
        
        // 3. Create a decoder
        let decoder = JSONDecoder()
        
        // 4. Create a property for the decoded data
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(fileName) from bundle.")
        }
        
        // 5. Return the ready-tu-use data
        return loaded
    }
    
}
