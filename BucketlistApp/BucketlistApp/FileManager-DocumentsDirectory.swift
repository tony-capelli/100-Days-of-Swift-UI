//
//  FileManager-DocumentsDirectory.swift
//  BucketlistApp
//
//  Created by Tony Capelli on 07/10/22.
//

import Foundation
extension FileManager {
    static var documentDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
