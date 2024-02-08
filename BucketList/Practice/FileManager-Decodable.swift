//
//  FileManager-Extension.swift
//  BucketList
//
//  Created by Rob Ranf on 1/30/24.
//

import Foundation

//extension FileManager {
//    func decode<T: Codable>(_ file: URL) -> T {
//        guard let url = self.url(forPublishingUbiquitousItemAt: file, expiration: nil) else {
//            fatalError("Failed to locate file \(file) in bundle")
//        }
//        
//        guard let data = try? Data(contentsOf: url) else {
//            fatalError("Failed to load \(file) from bundle")
//        }
//        
//        let decoder = JSONDecoder()
//        
//        let formatter = DateFormatter()
//        formatter.dateFormat = "y-MM-dd"
//        decoder.dateDecodingStrategy = .formatted(formatter)
//        
//        guard let loaded = try? decoder.decode(T.self, from: data) else {
//            fatalError("Failed to decode \(file) from bundle")
//        }
//        return loaded
//    }
//}
