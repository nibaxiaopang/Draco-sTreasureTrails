//
//  ImageQuizViewController.swift
//  DracosTreasureTrails
//
//  Created by Draco’s Treasure Trails on 2024/12/24.
//

import UIKit

class TreasureImageQuizViewController: UIViewController {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var scoreLabel: UILabel!

    var questions = [TreasureQuestion]()
    var currentQuestionIndex = 0
    var score = 0
    var shuffledImages = [String]() // Holds shuffled images for display

    override func viewDidLoad() {
        super.viewDidLoad()
        showHowToPlayAlert() // Show "How to Play" alert when the game starts
        setupQuestions()
        setupCollectionView()
        showQuestion()
    }

    func showHowToPlayAlert() {
        let alert = UIAlertController(
            title: "How to Play",
            message: """
            Welcome to the Image Quiz Game!
            
            - A question will appear at the top.
            - Four images will be displayed below the question.
            - Tap the correct image that answers the question.
            - Earn 1 point for each correct answer.
            - Try to score as high as possible!
            
            Good luck!
            """,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Start", style: .default))
        present(alert, animated: true)
    }

    func setupQuestions() {
        
        questions = [
            TreasureQuestion(
                questionText: "Which is the Eiffel Tower?",
                correctImage: "eiffel_tower", // Correct image name
                wrongImages: ["statue_of_liberty", "big_ben", "pyramid"]
            ),
            TreasureQuestion(
                questionText: "Which is the Statue of Liberty?",
                correctImage: "statue_of_liberty",
                wrongImages: ["eiffel_tower", "big_ben", "pyramid"]
            ),
            TreasureQuestion(
                questionText: "Which is the Great Wall of China?",
                correctImage: "great_wall",
                wrongImages: ["taj_mahal", "colosseum", "christ_the_redeemer"]
            ),
            TreasureQuestion(
                questionText: "Which is the Taj Mahal?",
                correctImage: "taj_mahal",
                wrongImages: ["great_wall", "colosseum", "christ_the_redeemer"]
            ),
            TreasureQuestion(
                questionText: "Which is the Colosseum?",
                correctImage: "colosseum",
                wrongImages: ["taj_mahal", "great_wall", "christ_the_redeemer"]
            ),
            TreasureQuestion(
                questionText: "Which is the Golden Gate Bridge?",
                correctImage: "golden_gate",
                wrongImages: ["brooklyn_bridge", "tower_bridge", "sydney_harbour_bridge"]
            ),
            TreasureQuestion(
                questionText: "Which is a Tiger?",
                correctImage: "tiger",
                wrongImages: ["lion", "cheetah", "leopard"]
            ),
            TreasureQuestion(
                questionText: "Which is an Elephant?",
                correctImage: "elephant",
                wrongImages: ["hippo", "rhino", "camel"]
            ),
            TreasureQuestion(
                questionText: "Which is the Leaning Tower of Pisa?",
                correctImage: "leaning_tower",
                wrongImages: ["eiffel_tower", "big_ben", "statue_of_liberty"]
            ),
            TreasureQuestion(
                questionText: "Which is a Penguin?",
                correctImage: "penguin",
                wrongImages: ["duck", "goose", "swan"]
            ),
            TreasureQuestion(
                questionText: "Which is a Peacock?",
                correctImage: "peacock",
                wrongImages: ["sparrow", "parrot", "owl"]
            ),
            TreasureQuestion(
                questionText: "Which is the Sydney Opera House?",
                correctImage: "sydney_opera_house",
                wrongImages: ["christ_the_redeemer", "big_ben", "pyramid"]
            ),
            TreasureQuestion(
                questionText: "Which is a Polar Bear?",
                correctImage: "polar_bear",
                wrongImages: ["grizzly_bear", "panda", "brown_bear"]
            ),
            TreasureQuestion(
                questionText: "Which is a Panda?",
                correctImage: "panda",
                wrongImages: ["koala", "polar_bear", "sloth"]
            ),
            TreasureQuestion(
                questionText: "Which is the Mount Everest?",
                correctImage: "mount_everest",
                wrongImages: ["k2", "kilimanjaro", "mount_fuji"]
            ),
            TreasureQuestion(
                questionText: "Which is the Burj Khalifa?",
                correctImage: "burj_khalifa",
                wrongImages: ["empire_state_building", "petronas_towers", "willis_tower"]
            ),
            TreasureQuestion(
                questionText: "Which is the Great Sphinx of Giza?",
                correctImage: "sphinx",
                wrongImages: ["pyramid", "colosseum", "taj_mahal"]
            ),
            TreasureQuestion(
                questionText: "Which is the Tower Bridge?",
                correctImage: "tower_bridge",
                wrongImages: ["brooklyn_bridge", "sydney_harbour_bridge", "golden_gate"]
            )
        ]
    }

    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
    }

    func showQuestion() {
        guard currentQuestionIndex < questions.count else {
            gameOver()
            return
        }

        let currentQuestion = questions[currentQuestionIndex]
        questionLabel.text = currentQuestion.questionText

        // Shuffle correct and wrong images
        shuffledImages = currentQuestion.wrongImages + [currentQuestion.correctImage]
        shuffledImages.shuffle()

        collectionView.reloadData()
        updateScoreLabel()
    }

    func handleAnswer(selectedImage: String) {
        let currentQuestion = questions[currentQuestionIndex]

        if selectedImage == currentQuestion.correctImage {
            score += 1
        }

        currentQuestionIndex += 1
        showQuestion()
    }

    func updateScoreLabel() {
        scoreLabel.text = "Score: \(score)"
    }

    func gameOver() {
        let alert = UIAlertController(
            title: "Game Over",
            message: "Your final score is \(score).",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Restart", style: .default) { _ in
            self.restartGame()
        })
        present(alert, animated: true)
    }

    func restartGame() {
        score = 0
        currentQuestionIndex = 0
        showQuestion()
    }
}
extension TreasureImageQuizViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4 // Always show 4 options
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! TreasureImageCell
        let imageName = shuffledImages[indexPath.item]
        cell.configure(with: imageName)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedImage = shuffledImages[indexPath.item]
        handleAnswer(selectedImage: selectedImage)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width / 2) - 6 , height: (collectionView.bounds.width / 2)) // Make it square
    }
}
