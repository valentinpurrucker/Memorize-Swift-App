//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Valentin Purrucker on 25.01.22.
//

import Foundation
import SwiftUI

class EmojiMemoryGame: ObservableObject {
	
	static let themes = [
		MemoryGame<String>.Theme(name: "Pets",
								 contents: ["🐶", "🐱", "🐻‍❄️", "🐷", "🐼", "🦄", "🐵", "🦆", "🦉", "🐯"],
								 numberOfPairsOfCards: 4, color: (1.0, 0.0, 0.0)),
		MemoryGame<String>.Theme(name: "Vehicles",
								 contents: ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚅", "✈️"],
								 numberOfPairsOfCards: 10, color: (0.0, 0.0, 1.0)),
		MemoryGame<String>.Theme(name: "Tech", contents: ["⌚️", "📱", "💻", "🖥", "🖨", "🖱", "💾", "📷", "📺", "⏰", "🕰"],
								 numberOfPairsOfCards: 3,
								 color: (0.639, 0.902, 0.208)),
		// to test task: 4 -> one theme has less emojies than the specified number of pairs
		MemoryGame<String>.Theme(name: "Test", contents: ["😀", "😅", "😍"],
								 numberOfPairsOfCards: 100,
								 color: (0.984, 0.573, 0.235))
	]
		
	static func createMemoryGame(theme: MemoryGame<String>.Theme) -> MemoryGame<String> {
		let cardContents = theme.contents.shuffled()
		return MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairsOfCards) { index in
			cardContents[index]
		}
	}
	
	static func chooseRandomTheme() -> MemoryGame<String>.Theme {
		themes[Int.random(in: 0..<themes.count)]
	}
	
	@Published private var model: MemoryGame<String>
	
	@Published private var chosenTheme: MemoryGame<String>.Theme
	
	var themeName: String {
		chosenTheme.name
	}
	
	var themeColor: MemoryGame<String>.Theme.Color {
		chosenTheme.color
	}
	
	var score: Int {
		model.score
	}
	
	var cards: Array<MemoryGame<String>.Card> {
		return model.cards
	}
	
	
	init() {
		// select a theme for a new game
		let theme = EmojiMemoryGame.chooseRandomTheme()
		chosenTheme = theme
		model = EmojiMemoryGame.createMemoryGame(theme: theme)
	}
	
	
	// MARK: - Intents
	
	func chooseCard(_ card: MemoryGame<String>.Card) {
		// you could also call: objectWillChange.send() -> Attr. @Published doesnt that automatically now whenever model changes.
		model.choose(card)
	}
	
	func startNewGame() {
		chosenTheme = EmojiMemoryGame.chooseRandomTheme()
		model = EmojiMemoryGame.createMemoryGame(theme: chosenTheme)
	}
}
