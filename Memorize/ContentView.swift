//
//  ContentView.swift
//  Memorize
//
//  Created by Valentin Purrucker on 22.01.22.
//

import SwiftUI

struct ContentView: View {
	
	@ObservedObject var game: EmojiMemoryGame
	
	
	var body: some View {
		NavigationView {
			VStack(alignment: .center) {
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
					.foregroundColor(.red)
				}
				.padding(.horizontal)
				.font(.largeTitle)
			}
			.padding(.horizontal)
			.navigationTitle("Memorize")
		}
	}
}

struct CardView: View {
	
	let card: MemoryGame<String>.Card
	
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
					.fill(.red)
			}
		}
	}
}















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		let emojiGame = EmojiMemoryGame()
		ContentView(game: emojiGame)
			.preferredColorScheme(.light)
.previewInterfaceOrientation(.portrait)
    }
}
