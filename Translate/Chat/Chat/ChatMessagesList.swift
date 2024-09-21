//
//  ChatMessageList.swift
//  Chat
//
//  Created by Ale Patrón on 4/3/24.
//

import SwiftUI

struct ChatMessagesList: View {

    @Bindable var viewModel: ChatViewModel

    var body: some View {
        ScrollView {
            ForEach(viewModel.messages) { message in
                MessageCell(message: message)
                    .padding(message.role.padding)
                    .id(message.id)
            }
        }
        .scrollPosition(id: $viewModel.scrollPosition)
        .defaultScrollAnchor(.bottom)
    }
}
