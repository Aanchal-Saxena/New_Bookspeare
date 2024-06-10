//
//  CreateQuizFormViewController.swift
//  New_Bookspeare
//
//  Created by Sahil Raj on 07/06/24.
//

import UIKit

class CreateQuizFormViewController: UIViewController, UITextFieldDelegate{
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
                self.view.endEditing(true)
            }
    
    var quiz: Quiz?
    
    @IBOutlet weak var quizImage: UIImageView!
    
    @IBOutlet weak var quizNameTextField: UITextField!
    
    
    @IBOutlet weak var quizdescriptionTextfield: UITextField!
    
    
    
    @IBOutlet weak var quesNumberStepper: UIStepper!
    
    @IBOutlet weak var stepperLabel: UILabel!
    
    
    
    
    
    var quizName: String?
       var quizDescription: String?
    var numberOfQuestions: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quesNumberStepper.minimumValue = 1 // Set minimum value for the stepper
                // Set initial value for the stepper label
        stepperLabel.text = "\(Int(quesNumberStepper.value))"
       

        // Do any additional setup after loading the view.
    }
    
    
    
    
    @IBAction func steppedValueChanged(_ sender: UIStepper) {
        
        // Update the stepper label with the selected value
                stepperLabel.text = "\(Int(sender.value))"
                // Update the numberOfQuestions variable
                numberOfQuestions = Int(sender.value)
    }
    
    
    @IBAction func createButtonTapped(_ sender: UIButton) {
        
        print("Create button tapped")
               print("Quiz Name: \(quizName ?? "nil")")
               print("Quiz Description: \(quizDescription ?? "nil")")
               print("Number of Questions: \(numberOfQuestions)")
               
               guard let name = quizNameTextField.text, !name.isEmpty,
                     let description = quizdescriptionTextfield.text, !description.isEmpty else {
                   // Show an alert if any of the fields are not properly filled
                   let alert = UIAlertController(title: "Incomplete", message: "Please fill all fields.", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                   present(alert, animated: true, completion: nil)
                   return
               }
               
               // Assuming QuizQuestion and QuizAnswer are placeholders
               let sampleQuestion = QuizQuestion(question: "Sample Question", correctAnswer: "Sample Answer", incorrectAnswers: ["Option 1", "Option 2", "Option 3"], category: "Sample Category")
               let sampleAnswer = QuizAnswer(text: "Sample Answer", isCorrect: true)
               
               if let image = quizImage.image {
                   quiz = Quiz(numberOfQuestion: numberOfQuestions, answers: [sampleAnswer], ques: sampleQuestion, description: description, quizImage: image)
               }
        self.quizName = name
               
               // Perform any additional actions after creating the quiz
               if let quiz = quiz {
                   print("Quiz created with name: \(name), description: \(description), number of questions: \(numberOfQuestions)")
                   // You can now use the 'quiz' object as needed
               }
        performSegue(withIdentifier: "showQuizQues", sender: nil)
        
        
           }
    
    @IBAction func editingDidend(_ sender: UITextField) {
        
        if sender == quizNameTextField {
                    self.quizName = sender.text
                } else if sender == quizdescriptionTextfield {
                    self.quizDescription = sender.text
                }
            }
            
          
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showQuizQues" {
            // Ensure the destination view controller is of the correct type
            guard let destinationVC = segue.destination as? CreateQuizQuestionViewController else {
                return
            }
            // Pass the quiz object to the destination view controller
            destinationVC.quiz = quiz
            destinationVC.quizName = quizName
        }
    }

    

}
