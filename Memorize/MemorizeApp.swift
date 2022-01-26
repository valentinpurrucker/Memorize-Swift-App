//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Valentin Purrucker on 22.01.22.
//

import SwiftUI

@main
struct MemorizeApp: App {
	
	let emojiGame = EmojiMemoryGame()
	
    var body: some Scene {
        WindowGroup {
            ContentView(game: emojiGame)
        }
    }
}
