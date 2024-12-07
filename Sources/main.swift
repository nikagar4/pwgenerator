// The Swift Programming Language
// https://docs.swift.org/swift-book

import ArgumentParser
import Foundation

enum CharacterType: Codable {
    case lowerCase, upperCase, specialCharacters, numbers
}

struct PWGenerator: ParsableCommand {

    static let configuration = CommandConfiguration(
        abstract: "Generates a random password", version: "0.0.1")

    @Argument(help: "Specified length") var length: Int = 8
    @Flag(name: .short, help: "Include uppercase letters") var upperCase = false
    @Flag(name: .short, help: "Include special characters") var specialCharacters = false
    @Flag(name: .short, help: "Include numbers") var numbers = false

    mutating func run() throws {
        let pwChars: [Character] = [Int](repeating: 0, count: length)
            .map { _ in pickARandomCharacter() }
            .compactMap { $0 }
        let pw = String(pwChars)

        print("Password generated!")
        print(pw)
    }

    func pickARandomCharacter() -> Character? {
        let ucase = "ABCDEFGHIJKLMNOPQRSTUVWYZ"
        let digits = "0123456789"
        let lcase = "abcdefghijklmnopqrstuvwyz"
        let symbols = "@#$%^&*;.,!"

        var characterRules: [CharacterType] = [.lowerCase]
        if upperCase {
            characterRules += [.upperCase]
        }
        if specialCharacters {
            characterRules += [.specialCharacters]
        }
        if numbers {
            characterRules += [.numbers]
        }
        guard let randomCharacterType = characterRules.randomElement() else {
            return nil
        }

        switch randomCharacterType {
        case .upperCase:
            return ucase.randomElement()!
        case .lowerCase:
            return lcase.randomElement()!
        case .numbers:
            return digits.randomElement()!
        case .specialCharacters:
            return symbols.randomElement()!
        }

    }
}

PWGenerator.main()
