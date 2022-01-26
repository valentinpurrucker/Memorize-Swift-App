//
//  MemoryGame.swift
//  Memorize
//
//  Created by Valentin Purrucker on 25.01.22.
//

import Foundation


struct MemoryGame<CardContent: Equatable> {
	private(set) var cards: [Card]
	
	private var indexOfFacedUpCard: Int?
	
	
	init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
		// make pair -> so two times the amount of pairs is needed in total
		cards = [Card]()
		for cardIndex in 0..<numberOfPairsOfCards {
			let content = createCardContent(cardIndex)
			cards.append(Card(content: content, id: cardIndex * 2))
			cards.append(Card(content: content, id: cardIndex * 2 + 1))
		}
	}
	
	
	mutating func choose(_ card: Card) {
		if let index = cards.firstIndex(where: { $0.id == card.id }),
			!cards[index].isFaceUp,
			!cards[index].isMatched {
				// could be handled with an if but theres not really a practically situation when the model should receive a wrong id
			if let faceUpCard = indexOfFacedUpCard {
				// check if previous faceup matches with current
				if cards[index].content == cards[faceUpCard].content {
					// these two cards have the same content -> match it
					cards[index].isMatched = true
					cards[faceUpCard].isMatched = true
				}
				indexOfFacedUpCard = nil
			} else {
				for i in cards.indices {
					cards[i].isFaceUp = false
				}
				indexOfFacedUpCard = index
			}
			cards[index].isFaceUp.toggle()
			print("Chosen card: \(card)")
		}
	}
	
	struct Card: Identifiable {
		var isFaceUp: Bool = false
		var isMatched: Bool = false
		
		var content: CardContent
		
		var id: Int
	}
}