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
    
    
    
    @IBOutlet weak var numberOfQuesTextField: UITextField!
    
    
    var quizName: String?
       var quizDescription: String?
       var numberOfQuestions: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       

        // Do any additional setup after loading the view.
    }
    
    @IBAction func createButtonTapped(_ sender: UIButton) {
        
        print("Create button tapped")
                print("Quiz Name: \(quizName ?? "nil")")
                print("Quiz Description: \(quizDescription ?? "nil")")
                print("Number of Questions: \(numberOfQuestions ?? -1)")
        
        guard let name = quizName, let description = quizDescription, let numberOfQues = numberOfQuestions else {
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
            quiz = Quiz(numberOfQuestion: numberOfQues, answers: [sampleAnswer], ques: sampleQuestion, description: description, quizImage: image)
        }
                
                // Perform any additional actions after creating the quiz
        print("Quiz created with name: \(name), description: \(description), number of questions: \(numberOfQues)")
    
            
    }
    
    @IBAction func editingDidend(_ sender: UITextField) {
        
        if sender == quizNameTextField {
            self.quizName = sender.text
        }
        else if sender == quizdescriptionTextfield {
            self.quizDescription = sender.text
        }
        else if sender == numberOfQuesTextField {
            if let text = sender.text, let number = Int(text) {
                self.numberOfQuestions = number
                print("Number of Questions Text Field: \(numberOfQuestions ?? -1)")
            }
            else {
                // Show an alert if the number of questions is not a valid integer
                let alert = UIAlertController(title: "Invalid Input", message: "Please enter a valid number for the number of questions.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        }
    }
    
  
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
