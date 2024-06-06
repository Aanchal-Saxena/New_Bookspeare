//
//  ClubsCreateViewController.swift
//  New_Bookspeare
//
//  Created by Sahil Raj on 05/06/24.
//

import UIKit

class ClubsCreateViewController: UIViewController {
    
    var bookclub: BookClub?
    
    @IBOutlet weak var bookclubImage: UIImageView!
    
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var descriptionTextField: UITextField!
    
    
    @IBOutlet weak var genreTextField: UITextField!
    
    
    @IBOutlet weak var createButton: UIButton!

    init?(coder: NSCoder, bookclub: BookClub?)
    {
        self.bookclub = bookclub
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.useUnderline()
        descriptionTextField.useUnderline()
        genreTextField.useUnderline()
        
        createButton.layer.borderWidth = 0.5
        createButton.layer.cornerRadius = 22
        createButton.layer.borderColor = UIColor.black.cgColor
        createButton.isEnabled = false
        updateCreateButtonState()
        
        
    }
    
    @IBAction func textEditingEnded(_ sender: Any) {
        updateCreateButtonState()
    }
   
    
    func updateCreateButtonState()
    {
        let nameText = nameTextField.text ?? ""
        let descriptionText = descriptionTextField.text ?? ""
        let genreText = genreTextField.text ?? ""
        //let image = UIImage(named: "one")
        createButton.isEnabled = !nameText.isEmpty && !descriptionText.isEmpty
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "saveUnwind" else { return }
        
        
        let name = nameTextField.text ?? ""
        let description = descriptionTextField.text ?? ""
        let genre = genreTextField.text ?? ""
        //let image = UIImage(named: "one")
        bookclub = BookClub(name: name, image: "one", genre: genre,description: description, members: 50)
        DataController.shared.appendbookclub(club: bookclub!)
    }

    
}
