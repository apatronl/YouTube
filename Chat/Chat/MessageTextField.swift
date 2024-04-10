//
//  MessageTextField.swift
//  Chat
//
//  Created by Ale Patrón on 4/3/24.
//

import SwiftUI

struct MessageTextField: View {

    @Binding var draftMessage: String

    var body: some View {
        TextField("Message...", text: $draftMessage)
            .textFieldStyle(.plain)
            .padding(8)
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(.blue, lineWidth: 1)
            )
    }
}
