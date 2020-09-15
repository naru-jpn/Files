//
//  Content.swift
//  
//
//  Created by Naruki Chigira on 2020/09/12.
//

import Foundation

public final class Content: Item {
    /// URL of this content.
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

    /// Return content.
    public var concrete: ConcreteItem {
        .content(self)
    }
}

extension Content: CustomStringConvertible, CustomDebugStringConvertible {
    public var description: String {
        "<Content: \(name)>"
    }

    public var debugDescription: String {
        "<Content: \(url.path)>"
    }
}
