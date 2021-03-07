//
//  IntentHandler.swift
//  CustomIntent
//
//  Created by Jack Wong on 2021/03/02.
//

import Intents

struct CharacterDetail {
    let name: String
    let avatar: String
    let healthLevel: Double
    let heroType: String
    
    static let availableCharacters = [
        CharacterDetail(name: "Best", avatar: "🐼", healthLevel: 0.14, heroType: "Forest Dweller"),
        CharacterDetail(name: "Happy", avatar: "🦄", healthLevel: 0.67, heroType: "Free Rangers"),
        CharacterDetail(name: "Sad", avatar: "🐳", healthLevel: 0.83, heroType: "Deep Sea Goer")
    ]
}

class IntentHandler: INExtension, CustomIntentIntentHandling {
    
    func resolveCharacter(for intent: CustomIntentIntent, with completion: @escaping (GameCharacterResolutionResult) -> Void) {
        
    }
    
    func provideCharacterOptionsCollection(for intent: CustomIntentIntent, with completion: @escaping (INObjectCollection<GameCharacter>?, Error?) -> Void) {
        // Iterate the available characters, creating
        // a GameCharacter for each one.
        let characters: [GameCharacter] = CharacterDetail.availableCharacters.map { character in
            let gameCharacter = GameCharacter(
                identifier: character.name,
                display: character.name
            )
            gameCharacter.name = character.name
            return gameCharacter
        }
        
        // Create a collection with the array of characters.
        let collection = INObjectCollection(items: characters)
        
        // Call the completion handler, passing the collection.
        completion(collection, nil)
    }
    
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }
    
}
