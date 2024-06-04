//
//  GenreViewController.swift
//  Register
//
//  Created by Batch-2 on 09/05/24.
//

import UIKit

class GenreViewController: UIViewController {
    
    
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
        print(selectedGenre)
        
    }
    
    func buttonProperties(button: UIButton)
    {
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 19
        button.layer.borderColor = UIColor.gray.cgColor
    }
    
    
    
    
    
    
    
    

}
