//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Valentin Purrucker on 22.01.22.
//

import SwiftUI

@main
struct MemorizeApp: App {
	
	private let emojiGame = EmojiMemoryGame()
	
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: emojiGame)
        }
    }
}
