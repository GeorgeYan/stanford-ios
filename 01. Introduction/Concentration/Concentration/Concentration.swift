//
//  ConcentrationModel.swift
//  Concentration
//
//  reated by Murad Kasim (mkasim@uni-sofia.bg) on 20/06/2018.
//  Copyright © 2018 company. All rights reserved.
//

import Foundation
import GameplayKit.GKRandomSource // Shuffle array

// Public API
class Concentration
{
    // Create an instance of [class]/[struct]
    //var cards = Array<Card>()
    
    // Create an instance of [class]/[struct]
    // Alternative declaration:
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    {
        get
        {
            var foundIndex: Int?
            
            for index in cards.indices
            {
                if cards[index].isFaceUp
                {
                    if foundIndex == nil
                    {
                        foundIndex = index
                    }
                    else
                    {
                        return nil
                    }
                }
            }
            
            return foundIndex
        }
        set(newValue)
        {
            for index in cards.indices
            {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int)
    {
        
        // DEBUG
        print("Index: \(index)")
        print("All cards indexes: \(cards)")
        
        if !cards[index].isMatched
        {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard,
                   matchIndex != index
            {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier
                {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                
                cards[index].isFaceUp = true
            }
            else
            {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
     
    // Init/Constructor
    init(numberOfPairsOfCards: Int)
    {
        for _ in 1...numberOfPairsOfCards
        {
            // let card = Card(identifier: identifier)
            // let matchingCard = card
        
            let card = Card()
            
            // [struct] is COPIED when it is passed
            //cards.append(card) // <- first  copy of card
            //cards.append(card) // <- second copy of card
            
            // Add arrays together:
            cards += [card, card]

            // DEBUG
            print("Array of cards:")
            NSLog("%@", cards);
            
            // Shuffle the cards
            cards = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: cards) as! [Card]
        }
    }
    
}
