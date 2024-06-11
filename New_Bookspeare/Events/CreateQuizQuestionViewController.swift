//
//  CreateQuizQuestionViewController.swift
//  New_Bookspeare
//
//  Created by Sahil Raj on 06/06/24.
//

import UIKit

class CreateQuizQuestionViewController: UIViewController {
    
   
    
    @IBOutlet weak var quizNameLabel: UILabel!
    
    
    @IBOutlet weak var quesTextField: UITextField!
    
    
    @IBOutlet weak var correctOption1: UITextField!
    
    
    @IBOutlet weak var incorrectOption2: UITextField!
    
    
    
    @IBOutlet weak var incorrectOption3: UITextField!
    
    
    @IBOutlet weak var incorrectOption4: UITextField!
    
    
    @IBOutlet weak var quesNumberLabel: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    
    var quiz: Quiz?
    var quizName: String?
    
    
    var numberOfQuestions = 3
    var userQuiz : [QuizQuestion] = []
    var currentQuestionIndex = 0
    var myQuiz: Quiz = Quiz(numberOfQuestion: 1, questions: [], description: "", quizImage: UIImage(named: "one")!, name: "")

    override func viewDidLoad() {
        super.viewDidLoad()
        if let quiz = quiz
        {
            self.myQuiz.numberOfQuestion = quiz.numberOfQuestion
            numberOfQuestions = quiz.numberOfQuestion
            
        }
        if let quizName = quizName
        {
            self.myQuiz.name = quizName
            quizNameLabel.text = quizName
        }
        
        
        
        
        
        
        quesNumberLabel.text = "1 out of \(numberOfQuestions)"

        // Do any additional setup after loading the view.
    }
    
    @IBAction func textEditingEnded(_ sender: UITextField) {
        
    }
    
    
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        
        guard let questionText = quesTextField.text, !questionText.isEmpty,
                      let correctAnswer = correctOption1.text, !correctAnswer.isEmpty,
                      let incorrectAnswer2 = incorrectOption2.text, !incorrectAnswer2.isEmpty,
                      let incorrectAnswer3 = incorrectOption3.text, !incorrectAnswer3.isEmpty,
                      let incorrectAnswer4 = incorrectOption4.text, !incorrectAnswer4.isEmpty else {
                    // Show an alert or some indication to the user that all fields must be filled
                    let alert = UIAlertController(title: "Incomplete", message: "Please fill all fields.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                    return
                }
                
                // Create a new quiz question
                let newQuestion = QuizQuestion(
                    question: questionText,
                    correctAnswer: correctAnswer,
                    incorrectAnswers: [incorrectAnswer2, incorrectAnswer3, incorrectAnswer4],
                    category: "multiple" // You can modify this to get the actual category if needed
                )
                
                // Add the new question to the userQuiz array
                userQuiz.append(newQuestion)
        self.myQuiz.addQuestion(newQuestion)
        
        
        
                
                // Increment the question index
                currentQuestionIndex += 1
                
                // Check if we have reached the required number of questions
                if currentQuestionIndex >= numberOfQuestions {
                    print("Quiz creation completed with questions: \(userQuiz)")
                    DataController.shared.appendQuiz(myQuiz: myQuiz)
                    
                    DataController.shared.printAllQuizzes()
                    
//                    for (index, question) in userQuiz.enumerated() {
//                        print("Question \(index + 1): \(question.question)")
//                        print("Correct Answer: \(question.correctAnswer)")
//                        print("Incorrect Answers: \(question.incorrectAnswers)")
//                        print("Category: \(question.category)")
//                        print("----------")
//                    }
                    let alert = UIAlertController(title: "Congratulations", message: "You have created your quiz!", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                                    // Optionally, you could navigate to another view controller or reset everything
                                    // self.performSegue(withIdentifier: "ShowQuizSummary", sender: self)
                        }))
                        present(alert, animated: true, completion: nil)
                                
                                return
                        }
                            
                            // Update the button title if this is the last question
                        updateButtonTitle()
                        resetTextFields()
                        updateQuestionNumberLabel()
        
    }
    func updateButtonTitle() {
        if currentQuestionIndex == numberOfQuestions - 1 {
            nextButton.setTitle("Done", for: .normal)
            } else {
                nextButton.setTitle("Next", for: .normal)
            }
        }
    
    func resetTextFields() {
        quesTextField.text = ""
        correctOption1.text = ""
        incorrectOption2.text = ""
        incorrectOption3.text = ""
        incorrectOption4.text = ""
        }
    
    func updateQuestionNumberLabel() {
           quesNumberLabel.text = "\(currentQuestionIndex + 1) out of \(numberOfQuestions)"
       }
    
}
