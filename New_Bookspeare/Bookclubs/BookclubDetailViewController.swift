//
//  BookclubDetailViewController.swift
//  New_Bookspeare
//
//  Created by Katyayani Singh on 10/06/24.
//

import UIKit

class BookclubDetailViewController: UIViewController {
    
    var bookclub: BookClub?
    
    init?(coder: NSCoder, bookclub: BookClub?)
    {
        self.bookclub = bookclub
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @IBOutlet weak var bookclubImage: UIImageView!
    
    
    @IBOutlet weak var bookclubName: UILabel!
    
    @IBOutlet weak var bookclubDescription: UILabel!
    
    
    @IBOutlet weak var members: UILabel!
    
    
    
    @IBOutlet weak var bookclubAdmin: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let bookclub = bookclub {
                    bookclubName.text = bookclub.name
                    bookclubDescription.text = bookclub.description
                    bookclubImage.image = UIImage(named: bookclub.image ?? "six")
                    // Set other properties if necessary
                } else {
                    // Handle the case where bookclub is nil
                    bookclubName.text = "No bookclub available"
                    bookclubDescription.text = "Description not available"
                    bookclubImage.image = UIImage(named: "six")
                }

        // Do any additional setup after loading the view.
    }
    


}
