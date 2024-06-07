//
//  QuizQuestionsViewController.swift
//  Swap
//
//  Created by Sahil Raj on 04/06/24.
//

import UIKit

class QuizQuestionsViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var nextButton: UIButton!
    
    
    var isSelected = false
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var quizProgressBar: UIProgressView!
    @IBOutlet weak var quizName: UILabel!
    @IBOutlet weak var answerBoxView: UIView!
    @IBOutlet weak var answerBoxView2: UIView!
    @IBOutlet weak var answerCheck1: UIImageView!
    @IBOutlet weak var answerCheck2: UIImageView!
    @IBOutlet weak var answerCheck3: UIImageView!
    @IBOutlet weak var answerCheck4: UIImageView!
    @IBOutlet weak var answerBoxView4: UIView!
    @IBOutlet weak var answerBoxView3: UIView!
    @IBOutlet weak var option1: UILabel!
    @IBOutlet weak var option2: UILabel!
    @IBOutlet weak var option3: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var option4: UILabel!
    
    
    
    let questions = [
        
        QuizQuestion(question: "What is the name of Percy's sword?", correctAnswer: "Riptide", incorrectAnswers: ["Backbiter", "Anaklusmos", "Maimer"], category: "Multiple"),
        QuizQuestion(question: "Which Greek god is Percy's father?", correctAnswer: "Poseidon", incorrectAnswers: ["Zeus", "Hades", "Apollo"], category: "Multiple"),
        QuizQuestion(question: "What is the name of Percy's mother?", correctAnswer: "Sally Jackson", incorrectAnswers: ["Rhea Jackson", "Rachel Jackson", "Sophie Jackson"], category: "Multiple"),
        QuizQuestion(question: "Who is the primary antagonist in the first series?", correctAnswer: "Kronos", incorrectAnswers: ["Gaea", "Ares", "Luke"], category: "Multiple"),
        QuizQuestion(question: "What is the name of Percy's half-brother?", correctAnswer: "Tyson", incorrectAnswers: ["Luke", "Grover", "Nico"], category: "Multiple"),
        QuizQuestion(question: "What is Annabeth's fatal flaw?", correctAnswer: "Hubris", incorrectAnswers: ["Loyalty", "Curiosity", "Kindness"], category: "Multiple"),
        QuizQuestion(question: "What type of creature is Grover?", correctAnswer: "Satyr", incorrectAnswers: ["Centaur", "Minotaur", "Cyclops"], category: "Multiple"),
        QuizQuestion(question: "What is the name of the ship used in 'The Sea of Monsters'?", correctAnswer: "The Princess Andromeda", incorrectAnswers: ["The Argo II", "The Queen Anne's Revenge", "The Black Pearl"], category: "Multiple"),
        QuizQuestion(question: "Which goddess is Annabeth's mother?", correctAnswer: "Athena", incorrectAnswers: ["Aphrodite", "Hera", "Artemis"], category: "Multiple"),
        QuizQuestion(question: "Who is the god of war that Percy faces?", correctAnswer: "Ares", incorrectAnswers: ["Mars", "Hades", "Zeus"], category: "Multiple"),
    ]
    
    var currentQuestionIndex = 0
       var score = 0
       var answers: [QuizAnswer] = []

       override func viewDidLoad() {
           super.viewDidLoad()
           configureLabels()
           loadQuestion()
           scoreLabel.text = "1 out of \(questions.count)"

           // Add tap gesture recognizers to each answerBoxView
           let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(answerBoxTapped(_:)))
           let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(answerBoxTapped(_:)))
           let tapGestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(answerBoxTapped(_:)))
           let tapGestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(answerBoxTapped(_:)))

           answerBoxView.addGestureRecognizer(tapGestureRecognizer1)
           answerBoxView2.addGestureRecognizer(tapGestureRecognizer2)
           answerBoxView3.addGestureRecognizer(tapGestureRecognizer3)
           answerBoxView4.addGestureRecognizer(tapGestureRecognizer4)

           // Set the initial appearance of the answer box views
           answerBoxAppearance(box: answerBoxView)
           answerBoxAppearance(box: answerBoxView2)
           answerBoxAppearance(box: answerBoxView3)
           answerBoxAppearance(box: answerBoxView4)
       }

       func configureLabels() {
           questionLabel.adjustsFontSizeToFitWidth = true
                   questionLabel.minimumScaleFactor = 0.5
                   option1.adjustsFontSizeToFitWidth = true
                   option1.minimumScaleFactor = 0.5
                   option2.adjustsFontSizeToFitWidth = true
                   option2.minimumScaleFactor = 0.5
                   option3.adjustsFontSizeToFitWidth = true
                   option3.minimumScaleFactor = 0.5
                   option4.adjustsFontSizeToFitWidth = true
                   option4.minimumScaleFactor = 0.5

                   // Enable multiline for labels
                   questionLabel.numberOfLines = 0
                   option1.numberOfLines = 0
                   option2.numberOfLines = 0
                   option3.numberOfLines = 0
                   option4.numberOfLines = 0
       }

       func generateAnswers(from question: QuizQuestion) -> [QuizAnswer] {
           var allAnswers = [QuizAnswer]()
           let correct = QuizAnswer(text: question.correctAnswer, isCorrect: true)
           let incorrects = question.incorrectAnswers.map { answer in QuizAnswer(text: answer, isCorrect: false) }
           allAnswers.append(contentsOf: [correct] + incorrects)
           return allAnswers.shuffled()
       }

       func loadQuestion() {
           let currentQuestion = questions[currentQuestionIndex]
           if currentQuestionIndex == questions.count - 1
           {
               nextButton.setTitle("Done", for: .normal)
           }
           questionLabel.text = currentQuestion.question
           answers = generateAnswers(from: currentQuestion)
           option1.text = answers[0].text
           option2.text = answers[1].text
           option3.text = answers[2].text
           option4.text = answers[3].text
           scoreLabel.text = "\(currentQuestionIndex + 1) out of \(questions.count)"
           

           // Update progress bar
           quizProgressBar.progress = Float(currentQuestionIndex + 1) / Float(questions.count)
           
           

           // Reset answer check images and box shadows
           resetAnswerChecks()
       }

       func resetAnswerChecks() {
           let answerChecks = [answerCheck1, answerCheck2, answerCheck3, answerCheck4]
           for answerCheck in answerChecks {
               answerCheck?.image = nil
           }

           let answerBoxes = [answerBoxView, answerBoxView2, answerBoxView3, answerBoxView4]
           for answerBox in answerBoxes {
               answerBox?.layer.shadowColor = UIColor.gray.cgColor
               answerBox?.layer.shadowOpacity = 0.5
           }
       }

       @IBAction func nextQuestionButton(_ sender: UIButton) {
           currentQuestionIndex += 1
           if currentQuestionIndex < questions.count {
               loadQuestion()
           } 
           
           else {
               // Handle end of quiz, e.g., show score
               showScore()
           }
       }

       func showScore() {
           
           let alertController = UIAlertController(title: "Quiz Finished", message: "Your score is \(score)/\(questions.count)", preferredStyle: .alert)
           let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
           alertController.addAction(okAction)
           present(alertController, animated: true, completion: nil)
           
           //performSegue(withIdentifier: "results", sender: score)
       }

       @objc func answerBoxTapped(_ sender: UITapGestureRecognizer) {
           guard let tappedBox = sender.view else { return }
           var answerIndex: Int?

           // Determine which answer box was tapped
           if tappedBox == answerBoxView {
               answerIndex = 0
           } else if tappedBox == answerBoxView2 {
               answerIndex = 1
           } else if tappedBox == answerBoxView3 {
               answerIndex = 2
           } else if tappedBox == answerBoxView4 {
               answerIndex = 3
           }

           // Update the corresponding answer check image and score
           if let index = answerIndex {
               let answer = answers[index]
               let imageView = [answerCheck1, answerCheck2, answerCheck3, answerCheck4][index]
               let imageName = answer.isCorrect ? "checkmark.circle.fill" : "x.circle.fill"
               imageView?.image = UIImage(systemName: imageName)
               imageView?.tintColor = answer.isCorrect ? UIColor.green : UIColor.red

               // Update the shadow color of the tapped box
               tappedBox.layer.shadowColor = answer.isCorrect ? UIColor.green.cgColor : UIColor.red.cgColor
               tappedBox.layer.shadowOpacity = 0.5

               // Update the score if the answer is correct
               if answer.isCorrect {
                   score += 1
               }
               
               
           }
       }

       func answerBoxAppearance(box: UIView) {
           box.layer.shadowColor = UIColor.gray.cgColor
           box.layer.shadowOpacity = 0.5
           box.layer.shadowOffset = CGSize(width: 0, height: 2)
           box.layer.shadowRadius = 4
           
           box.translatesAutoresizingMaskIntoConstraints = false

                   // Ensure the box adjusts its height based on the content
        box.heightAnchor.constraint(greaterThanOrEqualTo: box.subviews.first!.heightAnchor, multiplier: 1.0).isActive = true
               
       }
   }
