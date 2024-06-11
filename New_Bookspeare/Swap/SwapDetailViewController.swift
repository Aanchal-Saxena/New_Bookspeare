//
//  SwapDetailViewController.swift
//  New_Bookspeare
//
//  Created by Sahil Raj on 11/06/24.
//

import UIKit


extension UIImageView {
    func loadImage(from url: URL) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
        }
    }
}

class SwapDetailViewController: UIViewController {
    
    
    @IBOutlet weak var swapImage: UIImageView!
    
    
    @IBOutlet weak var bookName: UILabel!
    
    
    
    @IBOutlet weak var swapDescription: UITextView!
    
    var swap : Swap?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let swap = swap {
                    configureView(with: swap)
                } else {
                    print("No swap data available.")
                }
            
            
    }
    
    
    private func configureView(with swap: Swap) {
            bookName.text = swap.bookTitle
            swapDescription.text = swap.description
            
            if let imageUrl = URL(string: swap.image) {
                // Assuming you have an extension or method to load an image from URL
                swapImage.loadImage(from: imageUrl)
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
