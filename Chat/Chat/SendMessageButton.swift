//
//  SendMessageButton.swift
//  Chat
//
//  Created by Ale Patrón on 4/3/24.
//

import SwiftUI

struct SendMessageButton: View {

    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "paperplane.circle.fill")
                .font(.title)
        }
    }
}
