//
//  FillInTheBlanksViewController.swift
//  DracosTreasureTrails
//
//  Created by Draco’s Treasure Trails on 2024/12/24.
//


import UIKit

class TreasureFillInTheBlanksViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var blanksCollectionView: UICollectionView!
    @IBOutlet weak var keyboardView: UIView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel! // Timer label for countdown

    var question: String = "I love drinking _____ juice."
    var correctAnswer: String = "GRAPE"
    var blanks: [String] = [] // Holds blanks or correct letters
    var userInput: String = "" // User's current input

    var timer: Timer?
    var timeRemaining: Int = 60 // Countdown timer in seconds

    override func viewDidLoad() {
        super.viewDidLoad()
        showHowToPlayAlert() // Show "How to Play" alert when the game starts
        setupGame()
        setupCollectionView()
        setupAlphabetKeyboard()
        timerLabel.text = "Time:"
    }

    func showHowToPlayAlert() {
        let alert = UIAlertController(
            title: "How to Play",
            message: """
            Welcome to the Fill in the Blanks Game!

            - A question will appear at the top with blanks to fill in.
            - Use the keyboard below to fill the blanks with the correct letters.
            - You have 60 seconds to guess the answer.
            - Press "Submit" when you're done to check your answer.

            Good luck!
            """,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Start", style: .default) { _ in
            self.startGame() // Start the game after dismissing the alert
        })
        present(alert, animated: true)
    }

    func startGame() {
        
        startTimer()
    }

    func setupGame() {
        // Initialize the question and blanks
        questionLabel.text = question
        blanks = Array(repeating: "_", count: correctAnswer.count) // Fill blanks
        blanksCollectionView.reloadData()
    }

    func setupCollectionView() {
        blanksCollectionView.delegate = self
        blanksCollectionView.dataSource = self
        blanksCollectionView.register(UINib(nibName: "BlankCell", bundle: nil), forCellWithReuseIdentifier: "BlankCell")
    }

    func setupAlphabetKeyboard() {
        // Clear previous subviews to prevent overlapping
        keyboardView.subviews.forEach { $0.removeFromSuperview() }
        
        // Create buttons for the alphabet dynamically
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let buttonSize: CGFloat = 50 // Square button size
        let spacing: CGFloat = 10    // Spacing between buttons
        let totalButtonWidth = buttonSize + spacing

        // Calculate the number of columns based on keyboardView width
        let availableWidth = keyboardView.bounds.width - 20 // 20 is padding for the edges
        let columns = Int(availableWidth / totalButtonWidth) // Number of buttons per row dynamically calculated
//        let columns = Int(availableWidth / totalButtonWidth)

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = spacing
        stackView.distribution = .equalSpacing

        // Iterate through letters and create buttons
        var currentRow: UIStackView? = nil
        for (index, letter) in letters.enumerated() {
            if index % columns == 0 {
                // Start a new row when the number of buttons in the row reaches the limit
                currentRow = UIStackView()
                currentRow?.axis = .horizontal
                currentRow?.alignment = .center
                currentRow?.spacing = spacing
                currentRow?.distribution = .equalSpacing
                stackView.addArrangedSubview(currentRow!)
            }
            
            // Create the button with character image
            let button = UIButton(type: .custom)
            button.setTitle(nil, for: .normal) // No text on button
            
            // Load the character image using the letter as its name
            if let characterImage = UIImage(named: String(letter)) {
                button.setImage(characterImage, for: .normal) // Set the image for the button
            } else {
                // Fallback if the image is missing
                button.setTitle(String(letter), for: .normal)
                button.setTitleColor(.white, for: .normal)
                button.backgroundColor = .systemGray
            }
            
            // Button styling
            button.backgroundColor = .systemTeal
            button.layer.cornerRadius = buttonSize / 2
            button.layer.shadowColor = UIColor.gray.cgColor
            button.layer.shadowOpacity = 0.6
            button.layer.shadowOffset = CGSize(width: 2, height: 2)
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor.white.cgColor
            
            // Button size
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
            button.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true

            // Add target action for button
            button.addTarget(self, action: #selector(alphabetButtonTapped(_:)), for: .touchUpInside)
            
            // Add the button to the current row
            currentRow?.addArrangedSubview(button)
        }

        // Add the main stack view to the keyboardView
        keyboardView.addSubview(stackView)

        // Auto Layout for stack view
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: keyboardView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: keyboardView.trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: keyboardView.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: keyboardView.bottomAnchor, constant: -10)
        ])
    }

    func startTimer() {
        timerLabel.text = "Time: \(timeRemaining)s"
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.timeRemaining -= 1
            self.timerLabel.text = "Time: \(self.timeRemaining)s"

            if self.timeRemaining <= 0 {
                self.timer?.invalidate()
                self.showAlert(title: "Time's Up!", message: "You ran out of time!")
            }
        }
    }

    @objc func alphabetButtonTapped(_ sender: UIButton) {
        guard let letter = sender.titleLabel?.text else { return }

        // Add the letter to the first blank space
        if let index = blanks.firstIndex(of: "_") {
            blanks[index] = letter
            blanksCollectionView.reloadData()
        }

        // Concatenate userInput to validate it later
        userInput.append(letter)
    }

    @IBAction func submitButtonTapped(_ sender: UIButton) {
        if userInput.uppercased() == correctAnswer {
            timer?.invalidate() // Stop timer on correct answer
            showAlert(title: "Correct!", message: "You guessed the correct answer!")
        } else {
            showAlert(title: "Wrong!", message: "Try again.")
        }
    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
    
extension TreasureFillInTheBlanksViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return blanks.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BlankCell", for: indexPath) as! TreasureBlankCell
        cell.configure(with: blanks[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Set the cell size dynamically based on the number of blanks
        let totalSpacing = CGFloat((blanks.count - 1) * 10) // Total spacing between cells
        let availableWidth = collectionView.frame.width - totalSpacing
        let cellWidth = availableWidth / CGFloat(blanks.count)
        return CGSize(width: cellWidth, height: cellWidth)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // Center the cells in the collection view
        let totalCellWidth = CGFloat(blanks.count) * (collectionView.frame.width / CGFloat(blanks.count))
        let totalSpacingWidth = CGFloat(blanks.count - 1) * 10
        let inset = max(0, (collectionView.frame.width - (totalCellWidth + totalSpacingWidth)) / 2)
        return UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
    }
}
