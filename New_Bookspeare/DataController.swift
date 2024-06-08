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

class DataController{
    
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
    var genres : [Genre] = [.Fantasy, .Fiction, .Mystery]
    
    static let shared = DataController()//singleton
    private let database = Database.database().reference()
    
    public func validateNewUser(with email:String, completion: @escaping((Bool) -> Void))
    {
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        database.child(safeEmail).observeSingleEvent(of: .value, with: {snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            
            completion(true)
        })
    }
    
    static func profilePictureUrl(safeEmail: String) -> String{
        //misty-Gmail-com_profile_picture.png
        return "\(safeEmail)_profile_picture.png"
    }
    
    static func safeEmail(email: String) -> String
    {
        var safeEmail: String
        {
            var safeEmail = email.replacingOccurrences(of: ".", with: "-")
            safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
            return safeEmail
        }
        return safeEmail
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
    public func insertUser(with user: User)
    {
        var userDict: [String: Any] = [:]
            
            userDict["id"] = user.id.uuidString
            userDict["username"] = user.username ?? ""
            userDict["email"] = user.email
            userDict["name"] = user.name ?? ""
            userDict["pronouns"] = user.pronouns ?? ""
            userDict["bio"] = user.bio ?? ""
            userDict["image"] = user.image ?? ""
            
            if let userGenres = user.userGenres {
                userDict["genres"] = userGenres.map { $0.rawValue }
            } else {
                userDict["genres"] = []
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
            
            database.child(user.safeEmail).setValue(userDict)
    }
        
    
    
    public func getAllUsers(completion: @escaping (Result<[[String: String]], Error>) -> Void)
    {
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
    
    private init(){
//        loadDummyGroupChat()
//        loadDummybookclub()
//        loadDummyswap()
//        loadDummyEvents()
//        loadDummySlider()
//        loadDummyFilterbutton()
        //loadDummyUserData()
        
        
    }
    
    
    func loadDummyUserData()
    {
        var user1 = User(
            id: UUID(),
            name: "Aanchal",
            email: "misty@gmail.com",
            pronouns: "they/them",
            bookclubs: bookclubs,
            image: "one",
            userGenres: [.Fantasy, .Fiction],
            bio: "Hi there :) I'm Misty"
        )

        let user2 = User(
            id: UUID(),
            name: "Aanchal",
            email: "misty@gmail.com",
            pronouns: "they/them",
            bookclubs: bookclubs,
            image: "one",
            userGenres: [.Fantasy, .Fiction],
            bio: "Hi there :) I'm Misty"
        )
        let user3 = User(
            id: UUID(),
            name: "Aanchal",
            email: "misty@gmail.com",
            pronouns: "they/them",
            bookclubs: bookclubs,
            image: "one",
            userGenres: [.Fantasy, .Fiction],
            bio: "Hi there :) I'm Misty"
        )
        let user4 = User(
            id: UUID(),
            name: "Aanchal",
            email: "misty@gmail.com",
            pronouns: "they/them",
            bookclubs: bookclubs,
            image: "one",
            userGenres: [.Fantasy, .Fiction],
            bio: "Hi there :) I'm Misty"
        )

        let user5 = User(
            id: UUID(),
            name: "Aanchal",
            email: "misty@gmail.com",
            pronouns: "they/them",
            bookclubs: bookclubs,
            image: "one",
            userGenres: [.Fantasy, .Fiction],
            bio: "Hi there :) I'm Misty"
        )

        let user6 = User(
            id: UUID(),
            name: "Aanchal",
            email: "misty@gmail.com",
            pronouns: "they/them",
            bookclubs: bookclubs,
            image: "one",
            userGenres: [.Fantasy, .Fiction],
            bio: "Hi there :) I'm Misty"
        )
        let user7 = User(
            id: UUID(),
            name: "Aanchal",
            email: "misty@gmail.com",
            pronouns: "they/them",
            bookclubs: bookclubs,
            image: "one",
            userGenres: [.Fantasy, .Fiction],
            bio: "Hi there :) I'm Misty"
        )

        let user8 = User(
            id: UUID(),
            name: "Aanchal",
            email: "misty@gmail.com",
            pronouns: "they/them",
            bookclubs: bookclubs,
            image: "one",
            userGenres: [.Fantasy, .Fiction],
            bio: "Hi there :) I'm Misty"
        )

        let user9 = User(
            id: UUID(),
            name: "Aanchal",
            email: "misty@gmail.com",
            pronouns: "they/them",
            bookclubs: bookclubs,
            image: "one",
            userGenres: [.Fantasy, .Fiction],
            bio: "Hi there :) I'm Misty"
        )

        let user10 = User(
            id: UUID(),
            name: "Aanchal",
            email: "misty@gmail.com",
            pronouns: "they/them",
            bookclubs: bookclubs,
            image: "one",
            userGenres: [.Fantasy, .Fiction],
            bio: "Hi there :) I'm Misty"
        )

        let user11 = User(
            id: UUID(),
            name: "Aanchal",
            email: "misty@gmail.com",
            pronouns: "they/them",
            bookclubs: bookclubs,
            image: "one",
            userGenres: [.Fantasy, .Fiction],
            bio: "Hi there :) I'm Misty"
        )

        let user12 = User(
            id: UUID(),
            name: "Aanchal",
            email: "misty@gmail.com",
            pronouns: "they/them",
            bookclubs: bookclubs,
            image: "one",
            userGenres: [.Fantasy, .Fiction],
            bio: "Hi there :) I'm Misty"
        )

        let user13 = User(
            id: UUID(),
            name: "Aanchal",
            email: "misty@gmail.com",
            pronouns: "they/them",
            bookclubs: bookclubs,
            image: "one",
            userGenres: [.Fantasy, .Fiction],
            bio: "Hi there :) I'm Misty"
        )
        user.append(contentsOf: [user1, user2, user3, user4, user5, user6, user7, user8, user9, user10, user11, user12, user13])
    }
    
    
    
    func loadDummyGroupChat(){
        let gc1 = GroupChat(name: "Potterheads", profile: "1")
        let gc2 = GroupChat(name: "Riodenverse", profile: "eight")
        let gc3 = GroupChat(name: "Mxtxers", profile: "five")
        let gc4 =  GroupChat(name: "Homies", profile: "one")
        let gc5 = GroupChat(name: "Dead Poet Society", profile: "four")
        let gc6 = GroupChat(name: "Cultivators", profile: "nine")
        let gc7 = GroupChat(name: "Wizards", profile: "two")
        let gc8 = GroupChat(name: "Rinakentverse", profile: "three")
        let gc9 = GroupChat(name: "Potterheads", profile: "1")
        let gc10 = GroupChat(name: "Riodenverse", profile: "eight")
        let gc11 = GroupChat(name: "Mxtxers", profile: "five")
        let gc12 = GroupChat(name: "Homies", profile: "one")
        let gc13 = GroupChat(name: "Dead Poet Society", profile: "four")
        let gc14 = GroupChat(name: "Cultivators", profile: "nine")
        let gc15 = GroupChat(name: "Wizards", profile: "two")
        let gc16 = GroupChat(name: "Rinakentverse", profile: "three")
        groupchats.append(gc1)
        groupchats.append(gc2)
        groupchats.append(gc3)
        groupchats.append(gc4)
        groupchats.append(gc5)
        groupchats.append(gc6)
        groupchats.append(gc7)
        groupchats.append(gc8)
        groupchats.append(gc9)
        groupchats.append(gc10)
        groupchats.append(gc11)
        groupchats.append(gc12)
        groupchats.append(gc13)
        groupchats.append(gc14)
        groupchats.append(gc15)
        groupchats.append(gc16)
        
    }
        
        
    func loadDummyFilterbutton(){
        
        
        // Existing filter instances
        let filter1 = BookclubFilter(bookclubFilterButton: "Fiction")
        let filter2 = BookclubFilter(bookclubFilterButton: "Non Fiction")
        
        // Create instances for the remaining categories
        let filter3 = BookclubFilter(bookclubFilterButton: "Fantasy")
        let filter4 = BookclubFilter(bookclubFilterButton: "Romance")
        let filter5 = BookclubFilter(bookclubFilterButton: "YA")
        let filter6 = BookclubFilter(bookclubFilterButton: "Literature")
        
        // Append all filters to bookclubFilterButton
        bookclubFilterButton.append(contentsOf: [filter1, filter2, filter3, filter4, filter5, filter6])
        
    }
    func loadDummybookclub(){
        
        // Existing club instances
        let bc1 = BookClub(name: "Detectives club", image: "1", genre: DataController.shared.genres, description: "A community for book lovers", members: 100)

        // Create instances for the remaining clubs
        let bc2 = BookClub(name: "Homies", image: "eight", genre: DataController.shared.genres, description: "A club for book friends", members: 50)
        let bc3 = BookClub(name: "Potterheads", image: "five", genre: DataController.shared.genres, description: "A club for Harry Potter fans", members: 200)
        let bc4 = BookClub(name: "Camp Half Blood", image: "one", genre: DataController.shared.genres, description: "A club for Percy Jackson fans", members: 150)

        // Append all clubs to bookclubs array
        bookclubs.append(contentsOf: [bc1, bc2, bc3, bc4])
        
    }
        
    func loadDummyswap(){
        
        // Existing swap instances
        let swap1 = Swap(bookTitle: "Card 1", image: "one")
        
        // Create instances for the remaining swaps
        let swap2 = Swap(bookTitle: "Card 2", image: "two")
        let swap3 = Swap(bookTitle: "Card 3", image: "three")
        let swap4 = Swap(bookTitle: "Card 2", image: "four")
        let swap5 = Swap(bookTitle: "Card 3", image: "five")
        let swap6 = Swap(bookTitle: "Card 3", image: "six")
        let swap7 = Swap(bookTitle: "Card 3", image: "seven")
        let swap8 = Swap(bookTitle: "Card 3", image: "harry")
        
        // Append all swaps to swap array
        swap.append(contentsOf: [swap1, swap2, swap3, swap4, swap5, swap6, swap7, swap8])
        
    }
    
    func loadDummySlider()
    {
        let s1 = SwapSlider(image: "swap")
        let s2 = SwapSlider(image: "go")
        let s3 = SwapSlider(image: "exchange")
        
        swapSlider.append(contentsOf: [s1, s2, s3])
    }
    
    func loadDummyEvents()
    {
        let event1 = Event(title: "Book Event", images: "1")
        let event2 = Event(title: "Book Event", images: "eight")
        let event3 = Event(title: "Book Event", images: "five")
        let event4 = Event(title: "Book Event", images: "one")
        events.append(event1)
        events.append(event2)
        events.append(event3)
        events.append(event4)

    }
    
    func getQuiz() -> [Quiz] { quiz }
    func getUser() -> [User] { user }
    func getUser(with index: Int) -> User { user[index]}
    func getSlider() -> [SwapSlider] { swapSlider }
    func getEvents() -> [Event] { events }
    func getEvent(with index: Int) -> Event { events[index] }
    func getBookclub(with index: Int) -> BookClub { bookclubs[index] }
    func getFilterBc(with index: Int) -> BookclubFilter { bookclubFilterButton[index] }
    func getGroupchat(with index: Int) -> GroupChat { groupchats[index] }
    func getGroupchat()-> [GroupChat] {groupchats}
    func getBookclubs()-> [BookClub] {bookclubs}
    func getFilterButton()-> [BookclubFilter] {bookclubFilterButton}
    func getSwapBooks()-> [Swap] {swap}
    func getSwapBook(with index: Int) -> Swap {swap[index]}
    func getSlider(with index: Int) -> SwapSlider {swapSlider[index]}
    func addUser(user1: User, at index: Int) {user.insert(user1, at: index)}
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
    
    func appendbookclub(club: BookClub){
        bookclubs.append(club)    }
  
   
    

}
