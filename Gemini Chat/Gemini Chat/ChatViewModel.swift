//
//  ChatViewModel.swift
//  Chat
//
//  Created by Ale Patrón on 4/3/24.
//

import Foundation
import Observation

@MainActor
@Observable
class ChatViewModel {

    // Private
    private let client: GeminiClient = GeminiClient()

    // Public
    var error: Error?
    var waitingForResponse: Bool = false
    var draftMessage: String = ""
    private(set) var messages: [Message] = []
    var scrollPosition: UUID? = nil

    func sendMessage() async {
        guard canSendMessage else { return }
        let latestMessage = addMessage(draftMessage, role: .sender)
        draftMessage.removeAll()

        // Send message to Gemini
        waitingForResponse = true
        let result = await client.send(message: latestMessage.text)
        waitingForResponse = false

        switch result {
        case .success(let response):
            addMessage(response, role: .receiver)
        case .failure(let error):
            self.error = error
        }
    }

    public var canSendMessage: Bool {
        !draftMessage.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    @discardableResult
    private func addMessage(_ text: String, role: Role) -> Message {
        let message = Message(role: role, text: text)
        messages.append(message)
        scrollPosition = message.id
        return message
    }
}
