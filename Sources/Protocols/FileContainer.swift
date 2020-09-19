//
//  FileContainer.swift
//  Files
//
//  Created by Naruki Chigira on 2020/09/19.
//

import Foundation

public protocol FileContainer: Locatable {

    /// Create new content.
    @discardableResult
    func createContent(name: String, data: Data) -> Bool

    /// Create new directory.
    @discardableResult
    func createDirectory(name: String) -> Bool
}

extension FileContainer {
    @discardableResult
    public func createContent(name: String, data: Data) -> Bool {
        let url = self.url.appendingPathComponent(name)
        return FileManager.default.createFile(atPath: url.path, contents: data, attributes: [:])
    }

    @discardableResult
    public func createDirectory(name: String) -> Bool {
        let url = self.url.appendingPathComponent(name)
        do {
            try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: [:])
        } catch {
            return false
        }
        return true
    }
}
