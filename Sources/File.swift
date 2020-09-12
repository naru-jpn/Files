//
//  File.swift
//  
//
//  Created by Naruki Chigira on 2020/09/12.
//

import Foundation

public final class File: Content {
    /// URL of this file.
    public let url: URL

    init(url: URL) {
        self.url = url
    }

    /// Is file exist or not.
    public var isExist: Bool {
        var isDirectory: ObjCBool = false
        guard FileManager.default.fileExists(atPath: url.path, isDirectory: &isDirectory) else {
            return false
        }
        return isDirectory.boolValue == false
    }

    /// Return file.
    public var concrete: ConcreteContent {
        .file(self)
    }
}

extension File: CustomStringConvertible, CustomDebugStringConvertible {
    public var description: String {
        "<File: \(name)>"
    }

    public var debugDescription: String {
        "<File: \(url.path)>"
    }
}
