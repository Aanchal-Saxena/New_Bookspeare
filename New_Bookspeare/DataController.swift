//
//  DataController.swift
//  New_Bookspeare
//
//  Created by Sahil Raj on 05/06/24.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage
import FirebaseDatabaseInternal




class DataController {
    
    static let bookClubsUpdatedNotification = Notification.Name("bookClubsUpdated")
    
    private var bookclubs: [BookClub] = []
    private var groupchats: [GroupChat] = []
    private var quizQuestions: [QuizQuestion] = []
    private var quizAnswers: [QuizAnswer] = []
    private var swap: [Swap] = []
    private var swapSlider: [SwapSlider] = []
    private var events: [Event] = []
    private var eventFilter: [EventFilter] = []
    var bookclubFilterButton: [BookclubFilter] = []
    var user: [User] = []
    var quiz: [Quiz] = []
    var genres: [Genre] = [.Fantasy, .Fiction, .Mystery]
    var bookClubsForSection1: [BookClub] = []
    var bookshelf: [Bookshelf] = []
    var books: [Book] = []
    
    static let shared = DataController() // singleton
    private let database = Database.database().reference()
    
    public func validateNewUser(with email: String, completion: @escaping ((Bool) -> Void)) {
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        database.child(safeEmail).observeSingleEvent(of: .value, with: { snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            completion(true)
        })
    }
    
    static func profilePictureUrl(safeEmail: String) -> String {
        return "\(safeEmail)_profile_picture.png"
    }
    
    static func bookclubPictureUrl(safeEmail: String) -> String {
        return "\(safeEmail)_bookclub_picture.png"
    }
    
    static func safeEmail(email: String) -> String {
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
    
    public func fetchBookClubs(forEmail email: String, completion: @escaping ([BookClub]) -> Void) {
        let safeEmail = DataController.safeEmail(email: email)
        
        database.child(safeEmail).child("bookclubs").observeSingleEvent(of: .value) { snapshot in
            guard let bookClubsDict = snapshot.value as? [String: [String: Any]] else {
                print("No book clubs found or failed to cast snapshot value.")
                completion([])
                return
            }
            
            var bookClubs: [BookClub] = []
            
            for (idString, dict) in bookClubsDict {
                guard
                    let name = dict["name"] as? String,
                    let image = dict["image"] as? String,
                    let description = dict["description"] as? String,
                    let members = dict["members"] as? Int,
                    let id = UUID(uuidString: idString)
                else {
                    print("Failed to parse book club data for id: \(idString)")
                    continue
                }
                
                let bookClub = BookClub(id: id, name: name, image: image, description: description, members: members)
                bookClubs.append(bookClub)
            }
            
            print("Fetched \(bookClubs.count) book clubs.")
            completion(bookClubs)
        }
    }
    
    
    public func fetchSwaps(forEmail email: String, completion: @escaping ([Swap]) -> Void) {
        let safeEmail = DataController.safeEmail(email: email)
        
        database.child(safeEmail).child("swaps").observeSingleEvent(of: .value) { snapshot in
            guard let swapsDict = snapshot.value as? [String: [String: Any]] else {
                print("No swaps found or failed to cast snapshot value.")
                completion([])
                return
            }
            
            var swaps: [Swap] = []
            
            for (idString, dict) in swapsDict {
                guard
                    let bookTitle = dict["bookTitle"] as? String,
                    let description = dict["description"] as? String,
                    let locationDict = dict["location"] as? [String: Double],
                    let latitude = locationDict["latitude"],
                    let longitude = locationDict["longitude"],
                    let image = dict["image"] as? String,
                    let id = UUID(uuidString: idString)
                else {
                    print("Failed to parse swap data for id: \(idString)")
                    continue
                }
                
                let location = Location(latitude: latitude, longitude: longitude)
                let swap = Swap(id: id, bookTitle: bookTitle, description: description, location: location, image: image)
                swaps.append(swap)
            }
            
            print("Fetched \(swaps.count) swaps.")
            completion(swaps)
        }
    }




    public func updateBookClubs(forEmail email: String, bookClubs: [BookClub], completion: @escaping (Bool) -> Void) {
        let safeEmail = DataController.safeEmail(email: email)
        let bookClubsDict = bookClubs.map { $0.toDictionary() }
        
        database.child(safeEmail).child("bookclubs").setValue(bookClubsDict) { error, _ in
            if let error = error {
                print("Failed to update book clubs: \(error.localizedDescription)")
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    
    

    public func updateSwap(swap: Swap, forEmail email: String, completion: @escaping (Error?) -> Void) {
        let safeEmail = DataController.safeEmail(email: email)
        
        // Reference to the user's swaps in the database
        let swapRef = Database.database().reference().child(safeEmail).child("swaps").child(swap.id.uuidString)
        
        // Save the swap to the database
        swapRef.setValue(swap.toDictionary()) { error, _ in
            completion(error)
        }
    }




    
    public func updateEvent(event: Event, forEmail email: String, completion: @escaping (Error?) -> Void) {
        let safeEmail = DataController.safeEmail(email: email)
        
        // Reference to the user's events in the database
        let eventRef = Database.database().reference().child(safeEmail).child("events").child(event.id.uuidString)
        
        // Save the event to the database
        eventRef.setValue(event.toDictionary()) { error, _ in
            completion(error)
        }
    }


   
    public func fetchEvents(forEmail email: String, completion: @escaping ([Event]) -> Void) {
        let safeEmail = DataController.safeEmail(email: email)
        
        database.child(safeEmail).child("events").observeSingleEvent(of: .value) { snapshot in
            guard let eventsDict = snapshot.value as? [String: [String: Any]] else {
                print("No events found or failed to cast snapshot value.")
                completion([])
                return
            }
            
            var events: [Event] = []
            
            for (idString, dict) in eventsDict {
                guard
                    let title = dict["title"] as? String,
                    let images = dict["images"] as? String,
                    let description = dict["description"] as? String,
                    let registeredMembers = dict["registeredMembers"] as? Int,
                    let address = dict["address"] as? String,
                    let id = UUID(uuidString: idString)
                else {
                    // Skip event if any required field is missing
                    continue
                }
                
                let event = Event(id: id, title: title, images: images, description: description, registeredMembers: registeredMembers, address: address)
                events.append(event)
            }
            
            print("Fetched \(events.count) events.")
            completion(events)
        }
    }



    
    
    
    
    public func updateUser(withEmail safeEmail: String, name: String?, bio: String?, pronouns: String?, completion: @escaping (Bool) -> Void) {
        print("update function called")
        var updates: [String: Any] = [:]
        
        // Add the properties to be updated to the updates dictionary
        if let name = name {
            updates["name"] = name
        }
        if let bio = bio {
            updates["bio"] = bio
        }
        if let pronouns = pronouns {
            updates["pronouns"] = pronouns
        }
        
        // Update user details in the "users" node
        database.child("users").child(safeEmail).updateChildValues(updates) { error, _ in
            if let error = error {
                print("Failed to update user: \(error.localizedDescription)")
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    public func insertUser(with user: User) {
        var userDict: [String: Any] = [:]
        
        userDict["id"] = user.id.uuidString
        userDict["username"] = user.username ?? ""
        userDict["email"] = user.email
        userDict["name"] = user.name ?? ""
        userDict["pronouns"] = user.pronouns ?? ""
        userDict["bio"] = user.bio ?? ""
        userDict["image"] = user.image ?? ""
        
        if let userGenres = user.userGenres {
            userDict["userGenres"] = userGenres.map { $0.rawValue }
        } else {
            userDict["userGenres"] = []
        }
        
        if let bookclubs = user.bookclubs {
            userDict["bookclubs"] = bookclubs.map { $0.toDictionary() }
        } else {
            userDict["bookclubs"] = []
        }
        
        if let friends = user.friends {
            userDict["friends"] = friends.map { $0.toDictionary() }
        } else {
            userDict["friends"] = []
        }
        if let swappedBooks = user.swappedBooks {
                userDict["swappedBooks"] = swappedBooks.map { $0.toDictionary() }
        } else {
                userDict["swappedBooks"] = []
        }
        
        database.child(user.safeEmail).setValue(userDict)
    }
    
    public func getAllUsers(completion: @escaping (Result<[[String: String]], Error>) -> Void) {
        database.child("users").observeSingleEvent(of: .value, with: { snapshot in
            guard let value = snapshot.value as? [[String: String]] else {
                completion(.failure(DatabaseError.failedToFetch))
                return
            }
            completion(.success(value))
        })
    }
    
    public enum DatabaseError: Error {
        case failedToFetch
    }
    
    private init() {
        loadDummyGroupChat()
        loadDummyBookclub()
        loadDummySwap()
        loadDummyEvents()
        loadDummySlider()
        loadDummyFilterButton()
        loadDummyUserData()
        loadDummyBookshelf()
        loadDummyBooks()
        
    }
    
    func loadDummyBookshelf()
    {
        let books1 = [
                    Book(title: "Percy Jackson & The Olympians: The Lightning Thief", author: "Rick Riordan", image: "", hooked: "If my life is going to mean anything, I have to live it myself."),
                    Book(title: "Harry Potter and the Sorcerer's Stone", author: "J.K. Rowling", image: "", hooked: "It does not do to dwell on dreams and forget to live."),
                    Book(title: "The Hunger Games", author: "Suzanne Collins", image: "", hooked: "May the odds be ever in your favor.")
                ]
                
                let books2 = [
                    Book(title: "To Kill a Mockingbird", author: "Harper Lee", image: "", hooked: "You never really understand a person until you consider things from his point of view."),
                    Book(title: "1984", author: "George Orwell", image: "", hooked: "Big Brother is Watching You.")
                ]
                
                let books3 = [
                    Book(title: "The Great Gatsby", author: "F. Scott Fitzgerald", image: "", hooked: "So we beat on, boats against the current, borne back ceaselessly into the past."),
                    Book(title: "Pride and Prejudice", author: "Jane Austen", image: "", hooked: "It is a truth universally acknowledged, that a single man in possession of a good fortune, must be in want of a wife."),
                    Book(title: "The Hobbit", author: "J.R.R. Tolkien", image: "", hooked: "In a hole in the ground there lived a hobbit.")
                ]
                
                let books4 = [
                    Book(title: "Moby-Dick", author: "Herman Melville", image: "", hooked: "Call me Ishmael."),
                    Book(title: "Jane Eyre", author: "Charlotte Brontë", image: "", hooked: "I am no bird; and no net ensnares me: I am a free human being with an independent will.")
                ]
                
                // Creating bookshelves
                let bookshelf1 = Bookshelf(name: "Fantasy Adventures", description: "Exciting journeys in fantastical worlds", books: books1, image: "11")
                let bookshelf2 = Bookshelf(name: "Dystopian Worlds", description: "Exploring dystopian futures", books: books2, image: "12")
                let bookshelf3 = Bookshelf(name: "Classic Literature", description: "Timeless literary masterpieces",  books: books3, image: "13")
                let bookshelf4 = Bookshelf(name: "Epic Tales", description: "Epic journeys and stories",  books: books4, image: "14")
                
        bookshelf.append(contentsOf: [bookshelf1, bookshelf2, bookshelf3, bookshelf4])
    }
    
    func loadDummyBooks()
    {
        let book1 = Book(title: "Percy Jackson & The Olympians: The Lightning Thief", author: "Rick Riordan", image: "", hooked: "If my life is going to mean anything, I have to live it myself.")
        let book2 = Book(title: "Harry Potter and the Sorcerer's Stone", author: "J.K. Rowling", image: "", hooked: "It does not do to dwell on dreams and forget to live.")
        let book3 = Book(title: "The Hunger Games", author: "Suzanne Collins", image: "", hooked: "May the odds be ever in your favor.")
        let book4 = Book(title: "To Kill a Mockingbird", author: "Harper Lee", image: "", hooked: "You never really understand a person until you consider things from his point of view.")
        let book5 = Book(title: "1984", author: "George Orwell", image: "", hooked: "Big Brother is Watching You.")
        let book6 = Book(title: "The Great Gatsby", author: "F. Scott Fitzgerald", image: "", hooked: "So we beat on, boats against the current, borne back ceaselessly into the past.")
        let book7 = Book(title: "Pride and Prejudice", author: "Jane Austen", image: "", hooked: "It is a truth universally acknowledged, that a single man in possession of a good fortune, must be in want of a wife.")
        let book8 = Book(title: "The Hobbit", author: "J.R.R. Tolkien", image: "", hooked: "In a hole in the ground there lived a hobbit.")
        let book9 = Book(title: "Moby-Dick", author: "Herman Melville", image: "", hooked: "Call me Ishmael.")
        let book10 = Book(title: "Jane Eyre", author: "Charlotte Brontë", image: "", hooked: "I am no bird; and no net ensnares me: I am a free human being with an independent will.")
        
        books.append(contentsOf: [book1, book2, book3, book4, book5, book6, book7, book8, book9, book10])
                
    }
    
    func loadDummyUserData() {
        let user1 = User(
            id: UUID(),
            username: "Misty",
            name: "Jasmine Agrawal",
            email: "misty@gmail.com",
            pronouns: "they/them",
            bookclubs: bookclubs,
            image: "one",
            userGenres: [.Fantasy, .Fiction],
            bio: "Hi there :) I'm Misty",
            friends: []
        )
        
        let user2 = User(
            id: UUID(),
            username: "John",
            name: "John Doe",
            email: "john@example.com",
            pronouns: "they/them",
            bookclubs: bookclubs,
            image: "two",
            userGenres: [.NonFiction, .Mystery],
            bio: "Hello, I'm John",
            friends: []
        )
        
        user.append(contentsOf: [user1, user2])
    }
    
    func loadDummyGroupChat() {
        let gc1 = GroupChat(name: "Potterheads", profile: "1")
        let gc2 = GroupChat(name: "Riodenverse", profile: "eight")
        
        groupchats.append(contentsOf: [gc1, gc2])
    }
    
    func loadDummyFilterButton() {
        let filter1 = BookclubFilter(bookclubFilterButton: "Fiction")
        let filter2 = BookclubFilter(bookclubFilterButton: "Non Fiction")
        
        bookclubFilterButton.append(contentsOf: [filter1, filter2])
    }
    
    func loadDummyBookclub() {
       
        // Create dummy data
        let bc1 = BookClub(id: UUID(), name: "Bookclub 1", image: "one", description: "Description for Bookclub 1", members: 10, admin: "Admin 1")
        let bc2 = BookClub(id: UUID(), name: "Bookclub 2", image: "two", description: "Description for Bookclub 2", members: 20, admin: "Admin 2")
        let bc3 = BookClub(id: UUID(), name: "Bookclub 3", image: "three", description: "Description for Bookclub 3", members: 30, admin: "Admin 3")
        let bc4 = BookClub(id: UUID(), name: "Bookclub 4", image: "four", description: "Description for Bookclub 4", members: 40, admin: "Admin 4")
        let bc5 = BookClub(id: UUID(), name: "Bookclub 5", image: "five", description: "Description for Bookclub 5", members: 50, admin: "Admin 5") 

        // Append dummy data to the bookclubs array
       
        bookclubs.append(contentsOf: [bc1, bc2, bc3, bc4, bc5])

        // Print bookclubs to verify the data
        for bc in bookclubs {
            print(bc.toDictionary())
        }

        
    }
    
    func loadDummySwap() {
        let location1 = Location(latitude: 40.7128, longitude: -74.0060) // New York
        let location2 = Location(latitude: 34.0522, longitude: -118.2437) // Los Angeles
        let location3 = Location(latitude: 51.5074, longitude: -0.1278) // London
        let location4 = Location(latitude: 48.8566, longitude: 2.3522) // Paris

        let swap1 = Swap(bookTitle: "Card 1", description: "Description for card 1", location: location1, image: "one")
        let swap2 = Swap(bookTitle: "Card 2", description: "Description for card 2", location: location2, image: "two")
        let swap3 = Swap(bookTitle: "Card 3", description: "Description for card 3", location: location3, image: "three")
        let swap4 = Swap(bookTitle: "Card 4", description: "Description for card 4", location: location4, image: "four")
        
        swap.append(contentsOf: [swap1,swap2, swap3, swap4])
    }
    
    func loadDummySlider() {
        let s1 = SwapSlider(image: "swap")
        let s2 = SwapSlider(image: "exchange")
        let s3 = SwapSlider(image: "go")
        
        swapSlider.append(contentsOf: [s1,s2,s3])
    }
    
    func loadDummyEvents() {
        let event1 = Event(title: "Potterheads", images: "10", description: "A thrilling book event in New York", registeredMembers: 100, address: "123 Main St, New York, NY")
        let event2 = Event(title: "Bookish Dreams", images: "11", description: "A thrilling book event in Los Angeles", registeredMembers: 150, address: "456 Elm St, Los Angeles, CA")
        let event3 = Event(title: "Mxtx", images: "13", description: "A thrilling book event in London", registeredMembers: 200, address: "789 King St, London, UK")
        let event4 = Event(title: "Rina Kenters", images: "14", description: "A thrilling book event in Paris", registeredMembers: 250, address: "1011 Rue de Paris, Paris, France")
        
        events.append(contentsOf: [event1, event2, event3, event4])
    }
    
    
    
    
    func getBookshelf() -> [Bookshelf] { bookshelf }
    func getBook() -> [Book] { books }
    func getBookshelf(with index: Int) -> Bookshelf { bookshelf[index] }
    func getBooks(with index: Int) -> Book { books[index] }
    func getBookclubsection1() -> [BookClub] { bookClubsForSection1}
    func getBookclubsection1(with index: Int) -> BookClub { bookClubsForSection1[index] }
    func getQuiz() -> [Quiz] { quiz }
    func getUser() -> [User] { user }
    func getUser(with index: Int) -> User { user[index] }
    func getSlider() -> [SwapSlider] { swapSlider }
    func getEvents() -> [Event] { events }
    func getEvent(with index: Int) -> Event { events[index] }
    func getBookclub(with index: Int) -> BookClub { bookclubs[index] }
    func getFilterBc(with index: Int) -> BookclubFilter { bookclubFilterButton[index] }
    func getGroupchat(with index: Int) -> GroupChat { groupchats[index] }
    func getGroupchat() -> [GroupChat] { groupchats }
    func getBookclubs() -> [BookClub] { bookclubs }
    func getFilterButton() -> [BookclubFilter] { bookclubFilterButton }
    func getSwapBooks() -> [Swap] { swap }
    func getSwapBook(with index: Int) -> Swap { swap[index] }
    func getSlider(with index: Int) -> SwapSlider { swapSlider[index] }
    func addUser(user1: User, at index: Int) { user.insert(user1, at: index) }
    func removeUser(at index: Int) -> User {
        return user.remove(at: index)
    }
    
    func addBookshelf(_ shelf: Bookshelf)
    {
        bookshelf.append(shelf)
    }
    
    func updateUser(_ users: User, at index: Int) {
        user[index] = users
    }
    
    func updateUser(withEmail email: String, updatedUser: User) {
        if let index = user.firstIndex(where: { $0.email == email }) {
            user[index] = updatedUser
        }
    }
    
    func appendBookclub(club: BookClub) {
        bookclubs.append(club)
    }
    
    func appendQuiz(myQuiz: Quiz){
        quiz.append(myQuiz)
    }

    
    
    func printAllQuizzes() {
        let quizzes = DataController.shared.getQuiz()
        
        for (quizIndex, quiz) in quizzes.enumerated() {
            print("Quiz \(quizIndex + 1): \(quiz.name)")
            print("Description: \(quiz.description)")
            print("Number of Questions: \(quiz.numberOfQuestion)")
            print("Quiz Image: \(quiz.quizImage)") // This will print the memory address of the UIImage. You might want to handle it differently.
            
            for (questionIndex, question) in quiz.questions.enumerated() {
                print("  Question \(questionIndex + 1): \(question.question)")
                print("    Correct Answer: \(question.correctAnswer)")
                print("    Incorrect Answers: \(question.incorrectAnswers.joined(separator: ", "))")
                print("    Category: \(question.category)")
            }
            
            print("----------")
        }
    }
}
