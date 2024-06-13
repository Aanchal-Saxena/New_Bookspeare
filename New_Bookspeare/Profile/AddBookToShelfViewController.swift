//
//  AddBookToShelfViewController.swift
//  New_Bookspeare
//
//  Created by Sahil Raj on 12/06/24.
//

import UIKit

class AddBookToShelfViewController: UIViewController {
    
    var shelf: Bookshelf?
    
    var index: Int?
    
    @IBOutlet weak var bookImage: UIImageView!
    
    
    @IBOutlet weak var bookName: UITextField!
    
    @IBOutlet weak var bookAuthor: UITextField!
    
    
    @IBOutlet weak var hooked: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func createButtontapped(_ sender: UIButton) {
        
        
        guard let bookName = bookName.text, !bookName.isEmpty,
        let author = bookAuthor.text, !author.isEmpty,
        let hookedQuote = hooked.text, !hookedQuote.isEmpty
        else {
            print("Details are incomplete.")
            return
        }
        
        var newBook = Book(title: bookName, author: author, image: "one", hooked: hookedQuote)
        DataController.shared.addBookToBookshelf(at: 0 , book: newBook)
        print(DataController.shared.getBookshelf(with: 0))
                
        
    }
    

}
