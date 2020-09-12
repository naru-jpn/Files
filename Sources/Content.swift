//
//  Content.swift
//  
//
//  Created by Naruki Chigira on 2020/09/12.
//

import Foundation

public protocol Content {
    /// URL of this content.
    var url: URL { get }

    /// Name of this content.
    var name: String { get }

    /// Content exist or not.
    var isExist: Bool { get }

    /// Return file or directory.
    var concrete: ConcreteContent { get }

    /// Remove content.
    func remove() throws

    /// Move content to destination directory.
    func move(to directory: Directory) throws

    /// Copy content to destination directory.
    func copy(to directory: Directory) throws
}

public extension Content {
    var name: String {
        url.lastPathComponent
    }

    func remove() throws {
        guard isExist else {
            return
        }
        try FileManager.default.removeItem(atPath: url.path)
    }

    func move(to directory: Directory) throws {
        guard isExist, directory.isExist else {
            return
        }
        try FileManager.default.moveItem(at: url, to: directory.url)
    }

    func copy(to directory: Directory) throws {
        guard isExist, directory.isExist else {
            return
        }
        try FileManager.default.copyItem(at: url, to: directory.url)
    }
}
