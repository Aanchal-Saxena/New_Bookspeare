//
//  QuizScoreViewController.swift
//  Swap
//
//  Created by Sahil Raj on 04/06/24.
//

import UIKit

class QuizScoreViewController: UIViewController {
    var score = 0
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "You scored \(score)"

        // Do any additional setup after loading the view.
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
