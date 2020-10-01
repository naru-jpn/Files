//
//  DataContainer.swift
//  Files
//
//  Created by Naruki Chigira on 2020/09/19.
//

import Foundation

public protocol DataContainer: Locatable {

    /// Contents of this file.
    var data: Data? { get }
}

extension DataContainer {

    public var data: Data? {
        do {
            return try Data(contentsOf: url)
        } catch {
            return nil
        }
    }
}
