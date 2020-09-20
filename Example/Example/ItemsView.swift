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
    let directory: Directory

    var body: some View {
        List(directory.items()) { item in
            switch item.objectified {
            case let .directory(directory):
                NavigationLink(
                    destination: ItemsView(directory: directory),
                    label: {
                        Text(item.name)
                    }
                )
            case let .content(content):
                Text(content.name)
            case .invalid:
                EmptyView()
            }
        }
        .navigationBarTitle(directory.name)
    }
}

struct ItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsView(directory: Files.root(.home))
    }
}
