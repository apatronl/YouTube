//
//  ChatViewModel.swift
//  Chat
//
//  Created by Ale Patrón on 4/3/24.
//

import Foundation

class ChatViewModel: ObservableObject {
    @Published var draftMessage: String = ""

    @Published private(set) var messages: [Message] = [
        Message(
            role: .receiver,
            text: "Here's to the crazy ones"
        ),
        Message(
            role: .receiver,
            text: "the misfits, the rebels, the troublemakers"
        ),
        Message(
            role: .sender,
            text: "the round pegs in the square holes"
        ),
        Message(
            role: .receiver,
            text: "The ones who see things differently"
        ),
        Message(
            role: .sender,
            text: "They're not fond of rules. And they have no respect for the status quo"
        ),
        Message(
            role: .sender,
            text: "You can quote them, disagree with them, glorify or vilify them..."
        ),
        Message(
            role: .receiver,
            text: "Because they change things. They push the human race forward."
        ),
        Message(
            role: .receiver,
            text: "And while some may see them as the crazy ones, we see genius."
        ),
        Message(
            role: .receiver,
            text: "Because the people who are crazy enough to think they can change the world, are the ones who do."
        ),
    ]

    @Published var scrollPosition: UUID? = nil

    func sendMessage() {
        guard canSendMessage else { return }
        // In a real chat app this would make a server call to send the message
        let message = Message(role: .sender, text: draftMessage)
        messages.append(message)
        scrollPosition = message.id
        draftMessage.removeAll()
    }

    public var canSendMessage: Bool {
        !draftMessage.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
