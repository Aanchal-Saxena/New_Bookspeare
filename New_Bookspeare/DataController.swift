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
    
    public func fetchBookClubs(forEmail email: String, completion: @escaping (BookClub) -> Void) {
        let safeEmail = DataController.safeEmail(email: email)
<<<<<<< HEAD
        database.child(safeEmail).child("bookclubs").observeSingleEvent(of: .value) { snapshot in
            guard let bookClubsArray = snapshot.value as? [[String: Any]] else {
=======
        database.child("abhi-gmail-com").child("bookclubs").child("0").observeSingleEvent(of: .value) { snapshot in
            guard let dict = snapshot.value as? [String: Any] else {
                return
            }
            
            //            let bookClubs: [BookClub] = bookClubsArray.compactMap { dict in
            guard
                let name = dict["name"] as? String,
                let image = dict["image"] as? String,
                let description = dict["description"] as? String,
                let members = dict["members"] as? Int else {
                return
            }
            //                else {
            //                    return nil
            //                }
            //
            //                let genres: [Genre] = genreRaw.compactMap { Genre(rawValue: $0) }
            //
            //                guard
            //                    !genres.isEmpty,
            //                    let description = dict["description"] as? String,
            //                    let members = dict["members"] as? Int
            //                else {
            //                    return nil
            //                }
            
            var book = BookClub(name: name, image: image, description: description, members: members)
            
            
            completion(book)
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
    
    
    

    public func updateSwappedBooks(forEmail email: String, swappedBooks: [Swap], completion: @escaping (Bool) -> Void) {
        let safeEmail = DataController.safeEmail(email: email)
        let swappedBooksDict = swappedBooks.map { $0.toDictionary() }
        
        database.child(safeEmail).child("swappedBooks").setValue(swappedBooksDict) { error, _ in
            if let error = error {
                print("Failed to update swapped books: \(error.localizedDescription)")
                completion(false)
            } else {
                completion(true)
            }
        }
    }


    public func fetchSwappedBooks(forEmail email: String, completion: @escaping (Result<[Swap], Error>) -> Void) {
        let safeEmail = DataController.safeEmail(email: email)
        database.child(safeEmail).child("swappedBooks").observeSingleEvent(of: .value) { snapshot in
            guard let swappedBooksArray = snapshot.value as? [[String: Any]] else {
>>>>>>> main
                completion(.failure(DatabaseError.failedToFetch))
                return
            }
            
            let swappedBooks: [Swap] = swappedBooksArray.compactMap { dict in
                guard
                    let bookTitle = dict["bookTitle"] as? String,
                    let description = dict["description"] as? String,
                    let locationDict = dict["location"] as? [String: Double],
                    let latitude = locationDict["latitude"],
                    let longitude = locationDict["longitude"],
                    let image = dict["image"] as? String
                else {
                    return nil
                }
                
                let location = Location(latitude: latitude, longitude: longitude)
                return Swap(bookTitle: bookTitle, description: description, location: location, image: image)
            }
            
            completion(.success(swappedBooks))
        }
    }
    
    public func updateEvents(forEmail email: String, events: [Event], completion: @escaping (Bool) -> Void) {
        let safeEmail = DataController.safeEmail(email: email)
        let eventsDict = events.map { $0.toDictionary() }
        
        database.child(safeEmail).child("events").setValue(eventsDict) { error, _ in
            if let error = error {
                print("Failed to update events: \(error.localizedDescription)")
                completion(false)
            } else {
                completion(true)
            }
        }
    }

   
    public func fetchEvents(forEmail email: String, completion: @escaping (Result<[Event], Error>) -> Void) {
        let safeEmail = DataController.safeEmail(email: email)
        database.child("users").child(safeEmail).child("events").observeSingleEvent(of: .value) { snapshot in
            guard let eventsArray = snapshot.value as? [[String: Any]] else {
                completion(.failure(DatabaseError.failedToFetch))
                return
            }
            
            let events: [Event] = eventsArray.compactMap { dict in
                guard
                    let title = dict["title"] as? String,
                    let images = dict["images"] as? String,
                    let description = dict["description"] as? String,
                    let address = dict["address"] as? String,
                    let registeredMembers = dict["registeredMembers"] as? Int
                else {
                    return nil
                }
                
                return Event(title: title, images: images, description: description, registeredMembers: registeredMembers, address: address)
            }
            
            completion(.success(events))
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
        
    }
    
    func loadDummyUserData() {
        let user1 = User(
            id: UUID(),
            username: "Misty",
            name: "Aanchal Saxena",
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
        
        let bc1 = BookClub(name: "Bookclub 1", image: "one")
        let bc2 = BookClub(name: "Bookclub 1", image: "two")
        let bc3 = BookClub(name: "Bookclub 1", image: "three")
        let bc4 = BookClub(name: "Bookclub 1", image: "four")
        let bc5 = BookClub(name: "Bookclub 1", image: "five")
        bookclubs.append(contentsOf: [bc1, bc2, bc3, bc4, bc5])
        
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
        let event1 = Event(title: "Book Event 1", images: "one", description: "A thrilling book event in New York", registeredMembers: 100, address: "123 Main St, New York, NY")
        let event2 = Event(title: "Book Event 2", images: "two", description: "A thrilling book event in Los Angeles", registeredMembers: 150, address: "456 Elm St, Los Angeles, CA")
        let event3 = Event(title: "Book Event 3", images: "three", description: "A thrilling book event in London", registeredMembers: 200, address: "789 King St, London, UK")
        let event4 = Event(title: "Book Event 4", images: "four", description: "A thrilling book event in Paris", registeredMembers: 250, address: "1011 Rue de Paris, Paris, France")
        
        events.append(contentsOf: [event1, event2, event3, event4])
    }
    
    
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
}
