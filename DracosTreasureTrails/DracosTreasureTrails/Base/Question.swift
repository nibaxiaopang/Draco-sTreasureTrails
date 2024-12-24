//
//  Question.swift
//  DracosTreasureTrails
//
//  Created by jin fu on 2024/12/24.
//


import UIKit

struct Question {
    let questionText: String
    let correctImage: String // Correct image name
    let wrongImages: [String] // Array of wrong image names
}


let questions = [
    (question: "I love drinking _____ juice.", answer: "GRAPE"),
    (question: "The capital of France is _____", answer: "PARIS"),
    (question: "A _____ a day keeps the doctor away.", answer: "APPLE"),
    (question: "The sun rises in the _____", answer: "EAST"),
    (question: "The opposite of hot is _____", answer: "COLD"),
    (question: "The _____ is known as the king of the jungle.", answer: "LION"),
    (question: "2 + 2 equals _____", answer: "FOUR"),
    (question: "The Great Wall of _____ is a famous landmark.", answer: "CHINA"),
    (question: "Water freezes at _____ degrees Celsius.", answer: "ZERO"),
    (question: "The largest planet in our solar system is _____", answer: "JUPITER"),
    (question: "The fastest land animal is the _____", answer: "CHEETAH"),
    (question: "An _____ is used to write on paper.", answer: "ERASER"),
    (question: "A _____ has four equal sides.", answer: "SQUARE"),
    (question: "The opposite of black is _____", answer: "WHITE"),
    (question: "We breathe in _____ to survive.", answer: "OXYGEN"),
    (question: "The Eiffel Tower is located in _____", answer: "PARIS"),
    (question: "The _____ is the largest ocean on Earth.", answer: "PACIFIC"),
    (question: "The tallest mammal is the _____", answer: "GIRAFFE"),
    (question: "The Mona Lisa was painted by _____", answer: "DA VINCI"),
    (question: "The _____ is the center of our solar system.", answer: "SUN"),
    (question: "The national bird of the United States is the _____", answer: "EAGLE"),
    (question: "The currency used in Japan is the _____", answer: "YEN"),
    (question: "A baby dog is called a _____", answer: "PUPPY"),
    (question: "The _____ is the hardest natural substance on Earth.", answer: "DIAMOND"),
    (question: "The primary colors are red, blue, and _____", answer: "YELLOW"),
    (question: "The first man to walk on the moon was Neil _____", answer: "ARMSTRONG"),
    (question: "The Statue of Liberty was a gift from _____", answer: "FRANCE"),
    (question: "The smallest continent in the world is _____", answer: "AUSTRALIA"),
    (question: "A group of lions is called a _____", answer: "PRIDE"),
    (question: "The _____ is the national flower of Japan.", answer: "CHERRY BLOSSOM"),
    (question: "The chemical symbol for water is _____", answer: "H2O"),
    (question: "The tallest mountain in the world is Mount _____", answer: "EVEREST"),
    (question: "Spiders have _____ legs.", answer: "EIGHT"),
    (question: "The first letter of the alphabet is _____", answer: "A"),
    (question: "The opposite of day is _____", answer: "NIGHT"),
    (question: "The _____ is known as man's best friend.", answer: "DOG"),
    (question: "A _____ is used to see faraway objects.", answer: "TELESCOPE"),
    (question: "The national flag of the United States has _____ stars.", answer: "FIFTY"),
    (question: "Humans have _____ senses.", answer: "FIVE"),
    (question: "A polygon with five sides is called a _____", answer: "PENTAGON"),
    (question: "_____ is the capital of Italy.", answer: "ROME")
]
