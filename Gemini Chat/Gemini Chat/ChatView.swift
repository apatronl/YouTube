//
//  ChatView.swift
//  Chat
//
//  Created by Ale Patrón on 4/3/24.
//

import SwiftUI

@MainActor
struct ChatView: View {

    @Bindable private var viewModel: ChatViewModel = ChatViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                ChatMessagesList(viewModel: viewModel)

                if viewModel.error != nil {
                    ErrorView()
                }

                HStack {
                    MessageTextField(draftMessage: $viewModel.draftMessage)
                    SendMessageButton {
                        Task {
                            await viewModel.sendMessage()
                        }
                    }
                    .disabled(!viewModel.canSendMessage)
                }
                .padding(8)
            }
            .navigationTitle("Gemini Chat")
        }
    }
}











//struct ContentView: View {
//
//    @Bindable private var client: GeminiClient = GeminiClient()
//
//    var body: some View {
//        VStack(spacing: 8) {
//            Text("`let foregroundColor = Color.green`")
//                .foregroundStyle(Color.green)
//            Text("**Bold text**")
//            Button("Send message") {
//                Task {
//                    await client.send(message: "Write SwiftUI code for a view that displays text messages in a chat")
//                }
//            }
//        }
//        .padding()
//    }
//}
#Preview {
    ChatView()
}
