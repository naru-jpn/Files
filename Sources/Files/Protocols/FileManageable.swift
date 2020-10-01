//
//  FileManageable.swift
//  Files
//
//  Created by Naruki Chigira on 2020/09/19.
//

import Foundation

public protocol FileManageable: Locatable {

    /// Remove item.
    func remove() throws

    /// Move item to destination file container.
    func move(to container: FileContainer) throws

    /// Copy item to destination file container.
    func copy(to container: FileContainer) throws
}

extension FileManageable {
    public func remove() throws {
        guard isExist else {
            return
        }
        try FileManager.default.removeItem(atPath: url.path)
    }

    public func move(to container: FileContainer) throws {
        guard isExist, container.isExist else {
            return
        }
        try FileManager.default.moveItem(at: url, to: container.url)
    }

    public func copy(to container: FileContainer) throws {
        guard isExist, container.isExist else {
            return
        }
        try FileManager.default.copyItem(at: url, to: container.url)
    }
}
