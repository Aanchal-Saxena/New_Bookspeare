//
//  DataController.swift
//  New_Bookspeare
//
//  Created by Sahil Raj on 05/06/24.
//

import Foundation

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
    
    
    static let shared = DataController()//singleton
    
    private init(){
        loadDummyGroupChat()
        loadDummybookclub()
        loadDummyswap()
        loadDummyEvents()
        loadDummySlider()
        loadDummyFilterbutton()
        
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
        let bc1 = BookClub(name: "Detectives club", image: "1", genre: "Fiction", description: "A community for book lovers", members: 100)

        // Create instances for the remaining clubs
        let bc2 = BookClub(name: "Homies", image: "eight", genre: "Fiction", description: "A club for book friends", members: 50)
        let bc3 = BookClub(name: "Potterheads", image: "five", genre: "Fiction", description: "A club for Harry Potter fans", members: 200)
        let bc4 = BookClub(name: "Camp Half Blood", image: "one", genre: "Fiction", description: "A club for Percy Jackson fans", members: 150)

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
    
    func appendbookclub(club: BookClub){
        bookclubs.append(club)    }

    

}
