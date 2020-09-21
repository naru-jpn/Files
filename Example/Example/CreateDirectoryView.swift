//
//  CreateDirectoryView.swift
//  Example
//
//  Created by Naruki Chigira on 2020/09/21.
//  Copyright © 2020 Naruki Chigira. All rights reserved.
//

import Files
import SwiftUI

struct CreateDirectoryView: View {
    private let directory: Directory
    @Binding var isDismissed: Bool

    @State private var name: String = ""
    @State private var isErrorAlertPresented: Bool = false

    init(directory: Directory, isDismissed: Binding<Bool>) {
        self.directory = directory
        self._isDismissed = isDismissed
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 24) {
                VStack(alignment: .center, spacing: 4) {
                    TextField("Title", text: $name)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            .padding(24)
            .navigationBarItems(
                leading: Button("Cancel") {
                    isDismissed.toggle()
                },
                trailing: Button("Create") {
                    if directory.item(named: name) == nil && directory.createDirectory(name: name) {
                        isDismissed.toggle()
                    } else {
                        isErrorAlertPresented.toggle()
                    }
                }
            )
            .navigationBarTitle("Create Directory")
            .alert(isPresented: $isErrorAlertPresented) {
                Alert(
                    title: Text("Error"),
                    message: Text("Failed to create directory: \(name)"),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}
