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

final class ItemsViewModel: ObservableObject {
    enum SheetAction {
        case content, directory
    }

    private var directoryObserver: Directory.Observer? = nil
    @Published private(set) var items: [Item]
    @Published var isActionSheetPresented: Bool = false
    @Published var isCreateItemViewPresented: Bool = false
    @Published var selectedAction: SheetAction = .content

    init(directory: Directory) {
        self.items = directory.items()
        directoryObserver = Directory.Observer(directory: directory) { [weak self] items in
            self?.items = items
        }
    }
}
