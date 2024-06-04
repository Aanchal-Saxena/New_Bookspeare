//
//  EventsDetailViewController.swift
//  Events
//
//  Created by Batch-2 on 27/05/24.
//

import UIKit

class EventsDetailViewController: UIViewController {
    
    
    
    @IBOutlet var eventCard: UIView!
    
    
    @IBOutlet var aboutEventLabel: UILabel!
    
    
    @IBOutlet var aboutEventView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardSetUp(eventCard: aboutEventView)
        cardSetUp(eventCard: eventCard)
        
      

        // Do any additional setup after loading the view.
    }
    
    func cardSetUp(eventCard: UIView)
    {
        eventCard.layer.borderColor = UIColor.gray.cgColor
        eventCard.layer.borderWidth = 0.3
                
                // Set the corner radius
        eventCard.layer.cornerRadius = 5.0
        eventCard.clipsToBounds = true
                
//                // Set the shadow
        eventCard.layer.shadowColor = UIColor.black.cgColor
        eventCard.layer.shadowOpacity = 0.1
        eventCard.layer.shadowOffset = CGSize(width: 3, height: 3)
        eventCard.layer.shadowRadius = 0.4
        eventCard.layer.masksToBounds = false
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
