//
//  ItemsViewModel.swift
//  Example
//
//  Created by Naruki Chigira on 2020/09/20.
//  Copyright © 2020 Naruki Chigira. All rights reserved.
//

import Files
import Foundation
import SwiftUI

final class ItemsViewModel {
    private var directoryObserver: Directory.Observer? = nil
    @State private(set) var items: [Item]

    init(directory: Directory) {
        self.items = directory.items()
        directoryObserver = Directory.Observer(directory: directory) { [weak self] items in
            self?.items = items
        }
        print(#function, directory)
    }

    deinit {
        print(#function)
    }
}
