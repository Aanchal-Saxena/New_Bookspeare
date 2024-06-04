//
//  FriendsTableViewController.swift
//  profile🙋‍♀️
//
//  Created by Jasmine Agrawal on 28/05/24.
//

import UIKit


class FriendsTableViewController: UITableViewController {
     
    var users: [Users] = [Users(firstName: "Ishika", lastName: "Chaudhary", email: "ishika0812@gmail.com", image: "🙋‍♀️"),
                         Users(firstName: "Anuj", lastName: "Singh", email: "anuj0812@gmail.com", image: "🙋🏽‍♂️"),
                         Users(firstName: "Nitin", lastName: "Upreti", email: "nitin890812@gmail.com", image: "🙋🏽‍♂️"),
                         Users(firstName: "Fahar", lastName: "Imran", email: "faharxx0812@gmail.com", image: "🤷🏼‍♂️"),
                         Users(firstName: "Mohit", lastName: "Gupta", email: "mohit12@gmail.com", image: "🙆🏻‍♂️"),
                         Users(firstName: "Divyansh", lastName: "Kaushik", email: "div90812@gmail.com", image: "🙇🏻‍♂️"),
                         Users(firstName: "Katyani", lastName: "Singh", email: "ishika0812@gmail.com", image: "🦸🏻‍♀️"),
                         Users( firstName: "Shekhar", lastName: "Patel", email: "ishika0812@gmail.com", image: "👨🏻‍🎨"),
                         Users(firstName: "Amit", lastName: "Saxena", email: "ishika0812@gmail.com", image: "💆🏻‍♂️"),
                         Users( firstName: "Shruti", lastName: "Agrawal", email: "ishika0812@gmail.com", image: "👩🏻‍🦰"),
                         Users( firstName: "Arpita", lastName: "Gupta", email: "ishika0812@gmail.com", image: "👩🏻‍🦱"),
                         Users(firstName: "Peter", lastName: "Kapoor", email: "ishika0812@gmail.com", image: "👩🏻‍🎤"),
                         Users(firstName: "Jasmine", lastName: "Sandals", email: "jas@gmail.com", image: "👩🏻‍🎤"),
                         Users(firstName: "Prince", lastName: "Agrawal", email: "Prince@gmail.com", image: "🙋🏽‍♂️"),
                         Users(firstName: "Deepak", lastName: "Singhal", email: "deepak@gmail.com", image: "👩🏻‍🎤"),
                         Users(firstName: "Vaishali", lastName: "Goyal", email: "vaishali@gmail.com", image: "👩🏻‍🦰"),
                         
                         
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendsTableViewCell
        
        let user = users[indexPath.row]
        cell.update(with: user)
       return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            users.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedUser = users.remove(at: fromIndexPath.row)
        users.insert(movedUser, at: to.row)

    }
   
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle
    {
        return .delete
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

}
