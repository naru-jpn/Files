//
//  Directory.swift
//  
//
//  Created by Naruki Chigira on 2020/09/12.
//

import Foundation

public typealias DirectoryProtocol = ItemProtocol & FileContainer

/// Represents directory.
public struct Directory: DirectoryProtocol, Identifiable {
    public let url: URL

    public let id: String

    init(url: URL) {
        self.url = url
        self.id = url.path
    }
}

extension Directory {
    /// Is directory exist or not.
    public var isExist: Bool {
        var isDirectory: ObjCBool = false
        guard FileManager.default.fileExists(atPath: url.path, isDirectory: &isDirectory) else {
            return false
        }
        return isDirectory.boolValue
    }

    // MARK: Get Contents or Directories

    /// Get all items contained this directory.
    public func items() -> [Item] {
        do {
            let urls = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: [])
            var results: [Item] = []
            for url in urls {
                let item = Item(url: url)
                switch item.objectified {
                case .content, .directory:
                    results.append(item)
                default:
                    continue
                }
            }
            return results
        } catch {
            return []
        }
    }

    /// Get item with applied name.
    public func item(named name: String) -> Item? {
        items().first(where: { $0.name == name })
    }

    /// Get all contents contained this directory.
    public func contents() -> [Content] {
        let items = self.items()
        var results: [Content] = []
        for item in items {
            switch item.objectified {
            case let .content(content):
                results.append(content)
            default:
                continue
            }
        }
        return results
    }

    /// Get content with applied name.
    public func content(named name: String) -> Content? {
        contents().first(where: { $0.name == name })
    }

    /// Get all directories contained this directory.
    public func directories() -> [Directory] {
        let items = self.items()
        var results: [Directory] = []
        for item in items {
            switch item.objectified {
            case let .directory(directory):
                results.append(directory)
            default:
                continue
            }
        }
        return results
    }

    /// Get directory with applied name.
    public func directory(named name: String) -> Directory? {
        directories().first(where: { $0.name == name })
    }
}

extension Directory {
    // MARK: Observation

    public final class Observer {
        /// Handler called when directory is changed.
        private let handler: ([Item]) -> ()

        /// File descriptor to observe update event of directory.
        private let fd: Int32

        /// Source to handle event.
        private var source: DispatchSourceFileSystemObject? = nil

        /// Ovservation is activated or not.
        private let isActivated: Bool

        public init(directory: Directory, handler: @escaping (([Item]) -> ())) {
            self.handler = handler
            fd = open(directory.url.path, O_EVTONLY)
            guard fd >= 0 else {
                isActivated = false
                return
            }
            isActivated = true
            source = DispatchSource.makeFileSystemObjectSource(fileDescriptor: fd, eventMask: .write)
            source?.setEventHandler {
                DispatchQueue.main.async { [weak self] in
                    self?.handler(directory.items())
                }
            }
            source?.resume()
        }

        deinit {
            close(fd)
        }
    }

    public func observe(_ handler: @escaping (([Item]) -> ())) -> Directory.Observer {
        return Directory.Observer(directory: self, handler: handler)
    }
}

extension Directory: CustomStringConvertible, CustomDebugStringConvertible {
    // MARK: Description

    public var description: String {
        "<Directory: \(name)>"
    }

    public var debugDescription: String {
        "<Directory: \(url.path)>"
    }
}
