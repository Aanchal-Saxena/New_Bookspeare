//
//  CreateShelfFormViewController.swift
//  New_Bookspeare
//
//  Created by Sahil Raj on 12/06/24.
//

import UIKit


class CreateShelfFormViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = books[indexPath.row] 
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        self.bookName.text = cell?.textLabel?.text
        self.tableView.isHidden = true
    }
    
    var books: [String] = []
    
    
    
    
    @IBOutlet weak var bookName: UITextField!
    
    @IBOutlet weak var image: UIImageView!
    
    
    @IBOutlet weak var name: UITextField!
    
    
  @IBOutlet weak var shelfDescription: UITextField!
    
    
    @IBOutlet weak var myView: UIView!
    
  
    @IBOutlet weak var dropdownBtn: UIButton!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isHidden = true
        loadBooks()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func editingDideEnd(_ sender: UITextField) {
        
    }
    func loadBooks() {
            let bookObjects = DataController.shared.getBook()
            books = bookObjects.map { $0.title }
            tableView.reloadData()
    }
    

    
    @IBAction func dropdownButtonTapped(_ sender: UIButton) {
        self.tableView.isHidden = false
        print("create dp button tapped")
    }
    
    
    
    @IBAction func createButtonTapped(_ sender: UIButton) {
        
        guard let shelfName = name.text, !shelfName.isEmpty,
        let shelfDescription = shelfDescription.text, !shelfDescription.isEmpty
        else {
            print("Bookshelf details are incomplete.")
            return
        }
        
        var newShelf = Bookshelf(name: shelfName, description: shelfDescription,  books: [], image: "one")
        DataController.shared.addBookshelf(newShelf)
        
    }
    
    @IBAction func unwindToProfileViewController(_ segue: UIStoryboardSegue) {
    
        }
    
    
}
