//
//  GeminiClient.swift
//  Gemini Chat
//
//  Created by Ale Patrón on 4/22/24.
//

import Foundation
import GoogleGenerativeAI

class GeminiClient {

    private lazy var model = GenerativeModel(name: "gemini-pro", apiKey: APIKey.default)
    private lazy var chat: Chat = model.startChat()

    func send(message: String) async -> Result<String, GenerateContentError> {
        do {
            let response = try await chat.sendMessage(message)
            if let text = response.text {
                return .success(text)
            }
        } catch let error as GenerateContentError {
            return .failure(error)
        } catch {
            return .failure(GenerateContentError.internalError(underlying: GenericError()))
        }
        return .failure(GenerateContentError.internalError(underlying: GenericError()))
    }
}

struct GenericError: Error {
}

extension GeminiClient {
    enum APIKey {

        // Fetch the API key from `GeminiChat.plist`
        static var `default`: String {
            guard let filePath = Bundle.main.path(forResource: "GeminiChat", ofType: "plist")
            else {
              fatalError("Couldn't find file 'GeminiChat.plist'.")
            }
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "API_KEY") as? String else {
              fatalError("Couldn't find key 'API_KEY' in 'GeminiChat.plist'.")
            }
            if value.starts(with: "_") {
              fatalError(
                "Follow the instructions at https://ai.google.dev/tutorials/setup to get an API key."
              )
            }
            return value
        }
    }
}
