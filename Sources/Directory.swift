//
//  File.swift
//  
//
//  Created by Naruki Chigira on 2020/09/12.
//

import Foundation

public final class Directory: Content {
    /// URL of this directory.
    public let url: URL

    init(url: URL) {
        self.url = url
    }

    /// Is directory exist or not.
    public var isExist: Bool {
        var isDirectory: ObjCBool = false
        guard FileManager.default.fileExists(atPath: url.path, isDirectory: &isDirectory) else {
            return false
        }
        return isDirectory.boolValue
    }

    /// Return directory.
    public var concrete: ConcreteContent {
        .directory(self)
    }

    // MARK: Get Files or Directories

    /// Get all contents contained this directory.
    public func contents() -> [Content] {
        do {
            let urls = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: [])
            var results: [Content] = []
            for url in urls {
                var isDirectory: ObjCBool = false
                guard FileManager.default.fileExists(atPath: url.path, isDirectory: &isDirectory) else {
                    continue
                }
                let result: Content = isDirectory.boolValue ? Directory(url: url) : File(url: url)
                results.append(result)
            }
            return results
        } catch {
            return []
        }
    }

    /// Get all files contained this directory.
    public func files() -> [File] {
        contents().compactMap { $0 as? File }
    }

    /// Get file with applied name.
    public func file(named name: String) -> File? {
        files().first(where: { $0.name == name })
    }

    /// Get all directories contained this directory.
    public func directories() -> [Directory] {
        contents().compactMap { $0 as? Directory }
    }

    /// Get directory with applied name.
    public func directory(named name: String) -> Directory? {
        directories().first(where: { $0.name == name })
    }

    // MARK: Create Files or Directories

    /// Create new file.
    @discardableResult
    public func createFile(name: String, data: Data) -> Bool {
        let url = self.url.appendingPathComponent(name)
        return FileManager.default.createFile(atPath: url.path, contents: data, attributes: [:])
    }

    /// Create new directory.
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

extension Directory: CustomStringConvertible, CustomDebugStringConvertible {
    public var description: String {
        "<Directory: \(name)>"
    }

    public var debugDescription: String {
        "<Directory: \(url.path)>"
    }
}
