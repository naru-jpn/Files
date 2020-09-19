//
//  Content.swift
//  
//
//  Created by Naruki Chigira on 2020/09/12.
//

import Foundation

public typealias ContentProtocol = ItemProtocol & DataContainer

/// Represents data content.
public struct Content: ContentProtocol, Identifiable {
    public let url: URL

    public let id: String = String(UUID().uuidString.prefix(8))

    init(url: URL) {
        self.url = url
    }
}

extension Content {
    /// Is content exist or not.
    public var isExist: Bool {
        var isDirectory: ObjCBool = false
        guard FileManager.default.fileExists(atPath: url.path, isDirectory: &isDirectory) else {
            return false
        }
        return isDirectory.boolValue == false
    }
}

extension Content: CustomStringConvertible, CustomDebugStringConvertible {
    // MARK: Description

    public var description: String {
        "<Content: \(name)>"
    }

    public var debugDescription: String {
        "<Content: \(url.path)>"
    }
}
