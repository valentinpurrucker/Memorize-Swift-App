//
//  MemoryGame.swift
//  Memorize
//
//  Created by Valentin Purrucker on 25.01.22.
//

import Foundation


struct MemoryGame<CardContent: Equatable> {
	private(set) var cards: [Card]
	
	// keep track of cards already shown to the user
	private var previouslySeenCards: [Card] = []
	
	private(set) var score = 0
	
	
	private var indexOfFaceUpCard: Int? {
		get { cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly }
		set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
	}
	
	
	init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
		// make pair -> so two times the amount of pairs is needed in total
		cards = []
		for cardIndex in 0..<numberOfPairsOfCards {
			let content = createCardContent(cardIndex)
			cards.append(Card(content: content, id: cardIndex * 2))
			cards.append(Card(content: content, id: cardIndex * 2 + 1))
		}
		cards.shuffle()
	}
	
	
	mutating func choose(_ card: Card) {
		if let index = cards.firstIndex(where: { $0.id == card.id }),
			!cards[index].isFaceUp,
			!cards[index].isMatched {
				// could be handled with an if but theres not really a practically situation when the model should receive a wrong id
			if let faceUpCard = indexOfFaceUpCard {
				// check if previous faceup matches with current
				if cards[index].content == cards[faceUpCard].content {
					// these two cards have the same content -> match it
					cards[index].isMatched = true
					cards[faceUpCard].isMatched = true
					score += 2
				} else if let _ =  previouslySeenCards.first(where: { $0.content == cards[faceUpCard].content &&
					$0.id != cards[faceUpCard].id }) {
					// if we didnt match but we've already seen the card before
					// check: is there a card in previously seen cards that has the same content but different id
					score -= 1
				}
			} else {
				indexOfFaceUpCard = index
			}
			cards[index].isFaceUp.toggle()
			if !previouslySeenCards.contains(where: { $0.id == card.id }) {
				previouslySeenCards.append(card)
			}
		}
	}
	
	struct Card: Identifiable {
		var isFaceUp = false
		var isMatched = false
		
		let content: CardContent
		
		let id: Int
	}
	
	
	struct Theme {
		let name: String
		let contents: [CardContent]
		
		let numberOfPairsOfCards: Int
		
		let color: Color
		
		init(name: String, contents: [CardContent], numberOfPairsOfCards: Int, color: Color) {
			self.name = name
			self.contents = contents
			self.numberOfPairsOfCards = min(contents.count, numberOfPairsOfCards)
			self.color = color
		}
		
		typealias Color = (r: Double, g: Double, b: Double)
	}	
}


extension Array {
	var oneAndOnly: Element? {
		if count == 1 {
			return first
		} else {
			return nil
		}
	}
}
