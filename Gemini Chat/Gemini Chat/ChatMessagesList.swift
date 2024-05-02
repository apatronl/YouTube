//
//  ChatMessageList.swift
//  Chat
//
//  Created by Ale Patrón on 4/3/24.
//

import SwiftUI

struct ChatMessagesList: View {

    @Bindable var viewModel: ChatViewModel
    @State private var loadingViewId: UUID? = UUID()

    var body: some View {
        ScrollView {
            ForEach(viewModel.messages) { message in
                MessageCell(message: message)
                    .padding(message.role.padding)
                    .id(message.id)
            }

            if viewModel.waitingForResponse {
                HStack {
                    LoadingView()
                    Spacer()
                }
                .id(loadingViewId)
                .padding(.leading, 8)
            }
        }
        .scrollPosition(id: viewModel.waitingForResponse ? $loadingViewId : $viewModel.scrollPosition, anchor: .bottom)
        .defaultScrollAnchor(.bottom)
    }
}
