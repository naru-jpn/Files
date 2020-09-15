//
//  Item.swift
//  
//
//  Created by Naruki Chigira on 2020/09/12.
//

import Foundation

public protocol Item {
    /// URL of this item.
    var url: URL { get }

    /// Name of this item.
    var name: String { get }

    /// Content exist or not.
    var isExist: Bool { get }

    /// Return content or directory.
    var concrete: ConcreteItem { get }

    // MARK: Controls

    /// Remove item.
    func remove() throws

    /// Move item to destination directory.
    func move(to directory: Directory) throws

    /// Copy item to destination directory.
    func copy(to directory: Directory) throws

    // MARK: Attributes

    /// Attributes of the item.
    var attributes: [FileAttributeKey: Any] { get }

    /// Item’s size, in bytes.
    ///
    /// Return 0 if the attributes has no entry for the key.
    var size: UInt64 { get }

    /// Item’s creation date.
    var creationDate: Date? { get }

    /// Item’s modification date.
    var modificationDate: Date? { get }
}

public extension Item {
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

    var attributes: [FileAttributeKey: Any] {
        do {
            return try FileManager.default.attributesOfItem(atPath: url.path)
        } catch {
            return [:]
        }
    }

    var size: UInt64 {
        (attributes as NSDictionary).fileSize()
    }

    var creationDate: Date? {
        (attributes as NSDictionary).fileCreationDate()
    }

    var modificationDate: Date? {
        (attributes as NSDictionary).fileModificationDate()
    }
}
