//
//  Files.swift
//  
//
//  Created by Naruki Chigira on 2020/09/12.
//

import Foundation

public final class Files {
    /// Kinds of auto created directory.
    ///
    /// - File System Basics
    ///   - https://developer.apple.com/library/archive/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/FileSystemOverview/FileSystemOverview.html
    public enum Root: CaseIterable {
        /// Application’s home directory.
        case home
        /// Use this directory to store user-generated content.
        case documents
        /// This is the top-level directory for any files that are not user data files.
        case library
        /// In general, this directory includes files that the app uses to run but that should remain hidden from the user.
        case applicationSupport
        /// Cache data can be used for any data that needs to persist longer than temporary data, but not as long as a support file.
        case caches
        /// Use this directory to write temporary files that do not need to persist between launches of your app.
        case tmp

        public var url: URL {
            switch self {
            case .home:
                return URL(fileURLWithPath: NSHomeDirectory())
            case .documents:
                return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            case .library:
                return FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)[0]
            case .applicationSupport:
                return FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
            case .caches:
                return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
            case .tmp:
                return URL(fileURLWithPath: NSTemporaryDirectory())
            }
        }
    }

    public class func root(_ target: Root) -> Directory {
        let url = target.url
        if FileManager.default.fileExists(atPath: url.path) == false {
            try! FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: [:])
        }
        return Directory(url: url)
    }
}
