//
//  UserGenreViewController.swift
//  New_Bookspeare
//
//  Created by Sahil Raj on 05/06/24.
//

import UIKit
import FirebaseDatabase

class UserGenreViewController: UIViewController {
    
    
    @IBOutlet var yaGenreButton: UIButton!
    
    @IBOutlet weak var horrorButton: UIButton!
    
    @IBOutlet weak var fictionButton: UIButton!
    
    @IBOutlet weak var romanceButton: UIButton!
    
    @IBOutlet weak var mysteryButton: UIButton!
    
    @IBOutlet weak var financeButton: UIButton!
    
    @IBOutlet weak var businessButton: UIButton!
    
    @IBOutlet weak var psychologyButton: UIButton!
    
    
    @IBOutlet weak var fantasyButton: UIButton!
    
    @IBOutlet weak var selfHelp: UIButton!
    
    @IBOutlet weak var historicalFiction: UIButton!
    
    @IBOutlet weak var nonfiction: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        buttonProperties(button: yaGenreButton)
        buttonProperties(button: horrorButton)
        buttonProperties(button: fictionButton)
        buttonProperties(button: romanceButton)
        buttonProperties(button: mysteryButton)
        buttonProperties(button: financeButton)
        buttonProperties(button: businessButton)
        buttonProperties(button: psychologyButton)
        buttonProperties(button: selfHelp)
        buttonProperties(button: historicalFiction)
        buttonProperties(button: nonfiction)
        buttonProperties(button: fantasyButton)
        
    }
    
    var selectedGenre : [String] = []
    
    @IBAction func genreButtonTapped(_ sender: UIButton) {
        
        sender.backgroundColor = UIColor(red: 245/255, green: 241/255, blue: 224/255, alpha: 1.0)
        sender.titleLabel?.textColor = .black
        
        selectedGenre.append(sender.titleLabel?.text ?? "")
        
        guard let email = UserDefaults.standard.value(forKey: "email") else { return  }
        let safeEmail = DataController.safeEmail(email: email as! String)
        
        let genreRef = Database.database().reference().child(safeEmail).child("userGenres")
        genreRef.setValue(selectedGenre) { error, _ in
                if let error = error {
                    print("Failed to update bio: \(error.localizedDescription)")
                } else {
                    print("Bio updated successfully.")
                }
        }
        selectedGenre.append(sender.titleLabel?.text ?? "")
        print(selectedGenre)
        
    }
    
    
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "showTabbar", sender: nil)
    }
    
    
    
    func buttonProperties(button: UIButton)
    {
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 19
        button.layer.borderColor = UIColor.gray.cgColor
    }
    

    
    
    
    
    
    
    

}
