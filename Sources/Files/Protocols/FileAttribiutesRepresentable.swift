//
//  FileAttribiutesRepresentable.swift
//  Files
//
//  Created by Naruki Chigira on 2020/09/19.
//

import Foundation

public protocol FileAttribiutesRepresentable: Locatable {

    /// Attributes of the file.
    var attributes: [FileAttributeKey: Any] { get }

    /// File's size, in bytes.
    ///
    /// Return 0 if the attributes has no entry for the key.
    var size: UInt64 { get }

    /// File’s creation date.
    var creationDate: Date? { get }

    /// File’s modification date.
    var modificationDate: Date? { get }
}

extension FileAttribiutesRepresentable {
    public var attributes: [FileAttributeKey: Any] {
        do {
            return try FileManager.default.attributesOfItem(atPath: url.path)
        } catch {
            return [:]
        }
    }

    public var size: UInt64 {
        (attributes as NSDictionary).fileSize()
    }

    public var creationDate: Date? {
        (attributes as NSDictionary).fileCreationDate()
    }

    public var modificationDate: Date? {
        (attributes as NSDictionary).fileModificationDate()
    }
}
