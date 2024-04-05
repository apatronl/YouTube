//
//  MessageCell.swift
//  Chat
//
//  Created by Ale Patrón on 4/3/24.
//

import SwiftUI

struct MessageCell: View {

    let message: Message

    var body: some View {
        HStack {
            if message.role == .sender { Spacer() }
            MessageBubble(message: message)
            if message.role == .receiver { Spacer() }
        }
    }
}

struct MessageBubble: View {

    let message: Message

    var body: some View {
        Text(message.text)
            .foregroundStyle(message.role.textColor)
            .padding(8)
            .background {
                UnevenRoundedRectangle(cornerRadii: message.role.cornerRadii)
                    .foregroundColor(message.role.bubbleColor)
            }
    }
}

// MARK: - Role-based UI

extension Role {
    var bubbleColor: Color {
        switch self {
        case .sender: return .blue
        case .receiver: return .init(uiColor: .init(red: 240 / 255, green: 238 / 255, blue: 237 / 255, alpha: 1))
        }
    }

    var textColor: Color {
        switch self {
        case .sender: return .white
        case .receiver: return .black
        }
    }

    var cornerRadii: RectangleCornerRadii {
        switch self {
        case .sender: return .init(topLeading: 10, bottomLeading: 10, topTrailing: 10)
        case .receiver: return .init(topLeading: 10, bottomTrailing: 10, topTrailing: 10)
        }
    }

    var padding: EdgeInsets {
        switch self {
        case .sender: return .init(top: 0, leading: 32, bottom: 0, trailing: 8)
        case .receiver: return .init(top: 0, leading: 8, bottom: 0, trailing: 32)
        }
    }
}
