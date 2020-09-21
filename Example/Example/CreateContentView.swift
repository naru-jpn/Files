//
//  CreateContentView.swift
//  Example
//
//  Created by Naruki Chigira on 2020/09/21.
//  Copyright © 2020 Naruki Chigira. All rights reserved.
//

import Files
import SwiftUI

struct CreateContentView: View {
    private let directory: Directory
    @Binding var isDismissed: Bool

    @State private var name: String = ""
    @State private var content: String = ""
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
                VStack(alignment: .center) {
                    TextEditor(text: $content)
                        .frame(height: 200)
                        .padding(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
                Spacer()
            }
            .padding(24)
            .navigationBarItems(
                leading: Button("Cancel") {
                    isDismissed.toggle()
                },
                trailing: Button("Create") {
                    guard content.isEmpty == false, let data = content.data(using: .utf8) else {
                        return
                    }
                    if directory.item(named: name) == nil && directory.createContent(name: name, data: data) {
                        isDismissed.toggle()
                    } else {
                        isErrorAlertPresented.toggle()
                    }
                }
            )
            .navigationBarTitle("Create Content")
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
