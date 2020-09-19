//
//  Item.swift
//  
//
//  Created by Naruki Chigira on 2020/09/12.
//

import Foundation

public typealias ItemProtocol = Locatable & FileAttribiutesRepresentable & FileManageable

public struct Item: ItemProtocol, Identifiable {
    public let url: URL

    public let id: String = String(UUID().uuidString.prefix(8))

    init(url: URL) {
        self.url = url
    }
}

extension Item {
    public enum Object {
        case directory(Directory)
        case content(Content)
        case invalid
    }

    public var objectified: Object {
        var isDirectory: ObjCBool = false
        guard FileManager.default.fileExists(atPath: url.path, isDirectory: &isDirectory) else {
            return .invalid
        }
        return isDirectory.boolValue ? .directory(Directory(url: url)) : .content(Content(url: url))
    }
}
