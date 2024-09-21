//
//  ChatViewModel.swift
//  Chat
//
//  Created by Ale Patrón on 4/3/24.
//

import Foundation
import Observation
import Translation

@MainActor
@Observable
class ChatViewModel {
    var translationConfiguration: TranslationSession.Configuration? = nil
    var draftMessage: String = ""

    private(set) var messages: [Message] = [
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

    var scrollPosition: UUID? = nil

    func sendMessage() {
        guard canSendMessage else { return }
        // In a real chat app this would make a server call to send the message
        let message = Message(role: .sender, text: draftMessage)
        messages.append(message)
        scrollPosition = message.id
        draftMessage.removeAll()
    }

    func triggerTranslation() {
        if translationConfiguration == nil {
            translationConfiguration = TranslationSession.Configuration(
                source: .init(identifier: "en-US"),
                target: .init(identifier: "es-419")
            )
            return
        }
        translationConfiguration?.invalidate()
    }

    func translateAllMessages(using session: TranslationSession) async {
        Task { //@MainActor in
            let requests: [TranslationSession.Request] = messages.enumerated().map { (index, message) in
                // Assign each request a client identifier.
                    .init(sourceText: message.text, clientIdentifier: "\(index)")
            }


            do {
                for try await response in session.translate(batch: requests) {
                    // Use the returned client identifier (the index) to map the request to the response.
                    guard let index = Int(response.clientIdentifier ?? "") else { continue }
                    messages[index].translation = response.targetText
                }
            } catch {
                // Handle any errors.
            }
        }
    }

    public var canSendMessage: Bool {
        !draftMessage.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
