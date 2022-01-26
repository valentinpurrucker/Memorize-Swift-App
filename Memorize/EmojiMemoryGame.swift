//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Valentin Purrucker on 25.01.22.
//

import Foundation

class EmojiMemoryGame: ObservableObject {
	
	static let emojies = ["🐶", "🐱", "🐻‍❄️", "🐷", "🐼", "🦄", "🐵", "🦆", "🦉", "🐯"]
	
	static func createMemoryGame() -> MemoryGame<String> {
		MemoryGame<String>(numberOfPairsOfCards: 4) { index in emojies[index] }
	}
	
	@Published private var model: MemoryGame<String> = createMemoryGame()
	
	var cards: Array<MemoryGame<String>.Card> {
		return model.cards
	}
	
	
	// MARK: - Intents
	
	func chooseCard(_ card: MemoryGame<String>.Card) {
		// you could also call: objectWillChange.send() -> Attr. @Published doesnt that automatically now whenever model changes.
		model.choose(card)
	}
}
