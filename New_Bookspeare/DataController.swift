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
        loadDummyData()
    }
    func loadDummyData(){
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
            
//        let note = Note(id: UUID(), title: "Note1", createDate: Date(), content: "hello world", tags: [], images: [])
//        let note1 = Note(id: UUID(), title: "Note2", createDate: Date(), content: "hello world", tags: [], images: [])
//        let note2 = Note(id: UUID(), title: "Note3", createDate: Date(), content: "hello world", tags: [], images: [])
//        
//        
//        notes.append(note)
//        notes.append(note1)
//        notes.append(note2)
    }
    
//    func getNotes()->[Note] {notes}
//    func getNote(with index: Int)->Note {notes [index]}
//    func getCount()->Int{notes.count}
//    
//    func appendNote(note:Note){
//        notes.append(note)
//    }
}
