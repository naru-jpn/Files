//
//  ItemsView.swift
//  Example
//
//  Created by Naruki Chigira on 2020/09/15.
//  Copyright © 2020 Naruki Chigira. All rights reserved.
//

import Files
import SwiftUI

struct ItemsView: View {
    private let directory: Directory
    @ObservedObject private var viewModel: ItemsViewModel

    init(directory: Directory) {
        self.directory = directory
        self.viewModel = ItemsViewModel(directory: directory)
    }

    var body: some View {
        List {
            ForEach(viewModel.items) { item in
                switch item.objectified {
                case let .directory(directory):
                    NavigationLink(
                        destination: ItemsView(directory: directory),
                        label: {
                            Text(item.name).lineLimit(1)
                        }
                    )
                case let .content(content):
                    Text(content.name).lineLimit(1)
                case .invalid:
                    EmptyView()
                }
            }
            .onDelete(perform: onDelete)
        }
        .listStyle(PlainListStyle())
        .navigationBarTitle(directory.name)
        .navigationBarItems(
            leading: EmptyView(),
            trailing: Button("＋") {
                viewModel.isActionSheetPresented = true
            }
            .actionSheet(isPresented: $viewModel.isActionSheetPresented) {
                ActionSheet(
                    title: Text("Select Action"),
                    message: nil,
                    buttons: [
                        .default(Text("Create Content")) {
                            viewModel.selectedAction = .content
                            viewModel.isCreateItemViewPresented.toggle()
                        },
                        .default(Text("Create Directory")) {
                            viewModel.selectedAction = .directory
                            viewModel.isCreateItemViewPresented.toggle()
                        },
                        .cancel()
                    ]
                )
            }
        )
        .sheet(isPresented: $viewModel.isCreateItemViewPresented) {
            switch viewModel.selectedAction {
            case .content:
                CreateContentView(directory: directory, isDismissed: $viewModel.isCreateItemViewPresented)
            case .directory:
                CreateDirectoryView(directory: directory, isDismissed: $viewModel.isCreateItemViewPresented)
            }
        }
    }

    private func onDelete(indexSet: IndexSet) {
        let items = indexSet.map({ viewModel.items[$0] })
        for item in items {
            try? item.remove()
        }
    }
}

struct ItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsView(directory: Root.directory(.home))
    }
}
