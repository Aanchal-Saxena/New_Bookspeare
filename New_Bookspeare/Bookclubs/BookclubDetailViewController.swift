//
//  BookclubDetailViewController.swift
//  New_Bookspeare
//
//  Created by Katyayani Singh on 10/06/24.
//

import UIKit

class BookclubDetailViewController: UIViewController {
    
    var bookclub: BookClub?
    
   
    
    
    @IBOutlet weak var bookclubImage: UIImageView!
    
    
    @IBOutlet weak var bookclubName: UILabel!
    
    @IBOutlet weak var bookclubDescription: UILabel!
    
    
    @IBOutlet weak var members: UILabel!
    
    
    
    @IBOutlet weak var bookclubAdmin: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Update UI with bookClub details
               if let bookClub = bookclub {
                   bookclubName.text = bookClub.name
                   bookclubDescription.text = bookClub.description
                   members.text = "\(String(describing: bookClub.members))"
                   
                   if !bookClub.image.isEmpty {
                       bookclubImage.image = UIImage(named: bookClub.image)
                   } else {
                       bookclubImage.image = UIImage(named: "defaultImage") // Provide a default image name
                   }
               } else {
                   // Handle the case where bookClub is nil
                   bookclubName.text = "No book club available"
                   bookclubDescription.text = "Description not available"
                   bookclubImage.image = UIImage(named: "defaultImage") // Provide a default image name
               }
           }
    
    


}
