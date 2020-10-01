//
//  Locatable.swift
//  Files
//
//  Created by Naruki Chigira on 2020/09/19.
//

import Foundation

public protocol Locatable {

    /// URL of this item.
    var url: URL { get }

    /// Name of this item.
    var name: String { get }

    /// Content exist or not.
    var isExist: Bool { get }
}

extension Locatable {
    public var name: String {
        url.lastPathComponent
    }

    public var isExist: Bool {
        var isDirectory: ObjCBool = false
        guard FileManager.default.fileExists(atPath: url.path, isDirectory: &isDirectory) else {
            return false
        }
        return true
    }
}
