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
				AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
					CardView(card)
						.padding(4)
						.onTapGesture {
							print("Clicked")
							game.chooseCard(card)
						}
				}
				.foregroundColor(game.themeColor)
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
	
	private let card: MemoryGameModel<String>.Card
	
	init(_ card: MemoryGameModel<String>.Card) {
		self.card = card
	}
	
	var body: some View {
		GeometryReader { geometry in
			ZStack {
				let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
				
				if card.isFaceUp {
					shape
						.fill(.white)
					shape
						.strokeBorder(lineWidth: DrawingConstants.lineWidth)
					Pie(startAngle: Angle(degrees: 360 - 90), endAngle: Angle(degrees: 270 - 90))
						.padding(5)
					Text(card.content)
						.font(font(in: geometry.size))
				} else if card.isMatched {
					shape.opacity(0)
				} else {
					shape
						.fill()
				}
			}
		}
	}
	
	private func font(in size: CGSize) -> Font {
		Font.system(size: min(size.height, size.width) * DrawingConstants.fontSizeScaleFactor)
	}
	
	private struct DrawingConstants {
		static let cornerRadius: CGFloat = 10
		static let fontSizeScaleFactor: Double = 0.6
		static let lineWidth: CGFloat = 3
		static let circleOpacity: CGFloat = 0.5
	}
}















struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
		let emojiGame = EmojiMemoryGame()
		emojiGame.chooseCard(emojiGame.cards.first!)
		return EmojiMemoryGameView(game: emojiGame)
			.preferredColorScheme(.light)
.previewInterfaceOrientation(.portrait)
    }
}
