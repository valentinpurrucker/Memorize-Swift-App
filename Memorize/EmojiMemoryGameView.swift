//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Valentin Purrucker on 22.01.22.
//

import SwiftUI

struct EmojiMemoryGameView: View {
	
	@ObservedObject var game: EmojiMemoryGame
	
	var newGame: some View {
		Button {
			game.startNewGame()
		} label: {
			Text("New Game")
		}
	}
	
	var body: some View {
		NavigationView {
			VStack(alignment: .leading) {
				Text("\(game.score) Points")
					.font(.body)
					
				ScrollView {
					LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]) {
						ForEach(game.cards) { card in
							CardView(card)
								.aspectRatio(2/3, contentMode: .fit)
								.onTapGesture {
									game.chooseCard(card)
								}
						}
					}
					.foregroundColor(Color(red: game.themeColor.r,
										   green: game.themeColor.g,
										   blue: game.themeColor.b,
										   opacity: 1))
				}
				.padding(.horizontal)
				.font(.largeTitle)
			}
			.padding(.horizontal)
			.navigationTitle(game.themeName)
			
			.toolbar {
				newGame
			}
		}
	}
}

struct CardView: View {
	
	private let card: MemoryGame<String>.Card
	
	init(_ card: MemoryGame<String>.Card) {
		self.card = card
	}
	
	var body: some View {
		ZStack {
			let shape = RoundedRectangle(cornerRadius: 10)
			
			if card.isFaceUp {
				shape
					.fill(.white)
				shape
					.strokeBorder(lineWidth: 3)
				Text(card.content)
					.font(.largeTitle)
			} else if card.isMatched {
				shape.opacity(0)
			} else {
				shape
					.fill()
			}
		}
	}
}















struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
		let emojiGame = EmojiMemoryGame()
		EmojiMemoryGameView(game: emojiGame)
			.preferredColorScheme(.light)
.previewInterfaceOrientation(.portrait)
    }
}
