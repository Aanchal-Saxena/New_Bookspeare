//
//  DataModel1.swift
//  New_Bookspeare
//
//  Created by Sahil Raj on 05/06/24.
//

import Foundation
import UIKit

// Follower model for user connections
class Friend: Codable {
    var name: String
    var email: String
    var id: UUID
    var profile: String?
    
    init(name: String, email: String, id: UUID, profile: String? = nil) {
        self.name = name
        self.email = email
        self.id = id
        self.profile = profile
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "name": name,
            "email": email,
            "id": id.uuidString,
            "profile": profile ?? ""
        ]
    }
          
}

// BookClub model for user book clubs
class BookClub: Codable {
    var name: String
    var image: String
    var genre: [Genre]?
    var description: String?
    var members: Int?
    
    init(name: String, image: String, genre: [Genre]? = nil, description: String? = nil, members: Int? = nil) {
        self.name = name
        self.image = image
        self.genre = genre
        self.description = description
        self.members = members
    }
    
    func toDictionary() -> [String: Any] {
            return [
                "name": name,
                "image": image,
                "genre": genre?.map { $0.rawValue } ?? [],
                "description": description ?? "",
                "members": members ?? 0
            ]
        }
}

class Address: Codable {
    var line1: String
    var countryCode: Int
    var city: String
    var state: String
    
    init(line1: String, countryCode: Int, city: String, state: String) {
        self.line1 = line1
        self.countryCode = countryCode
        self.city = city
        self.state = state
    }
}

// User model for user data
class User: Codable {
    var id : UUID
    var username: String?
    var name: String?
    var email: String
    var pronouns: String?
    var bookclubs: [BookClub]?
    var image: String?
    var userGenres: [Genre]?
    var bio: String?
    var friends: [Friend]?
    
    var safeEmail: String
    {
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
    
    var profilePictureUrl: String{
        //misty-Gmail-com_profile_picture.png
        return "\(safeEmail)_profile_picture.png"
    }
    
    init(id: UUID, username: String? = nil, name: String? = nil, email: String, pronouns: String? = nil, bookclubs: [BookClub]? = nil, image: String? = nil, userGenres: [Genre]? = nil, bio: String? = nil, friends: [Friend]? = nil) {
        self.id = id
        self.username = username
        self.name = name
        self.email = email
        self.pronouns = pronouns
        self.bookclubs = bookclubs
        self.image = image
        self.userGenres = userGenres
        self.bio = bio
        self.friends = friends
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "id": id.uuidString,
            "username": username ?? "",
            "name": name ?? "",
            "email": email,
            "pronouns": pronouns ?? "",
            "image": image ?? "",
            "bio": bio ?? "",
            "bookclubs": bookclubs?.map { $0.toDictionary() } ?? [],
            "userGenres": userGenres?.map { $0.rawValue } ?? [],
            "friends": friends?.map { $0.toDictionary() } ?? []
        ]
    }
}

// Event model for event details
class Event: Codable {
    let title: String
    let images: String
    
    init(title: String, images: String) {
        self.title = title
        self.images = images
    }
}

class EventFilter: Codable {
    var eventFilterButton: String
    
    init(eventFilterButton: String) {
        self.eventFilterButton = eventFilterButton
    }
}

class BookclubFilter: Codable {
    var bookclubFilterButton: String
    
    init(bookclubFilterButton: String) {
        self.bookclubFilterButton = bookclubFilterButton
    }
}

// GroupChat model for group chat details
class GroupChat: Codable {
    let name: String
    let profile: String
    
    init(name: String, profile: String) {
        self.name = name
        self.profile = profile
    }
}

// DirectChat model for direct chat details
class DirectChat: Codable {
    var users: [Int]
    var messages: [String]
    var status: Status
    var organization: String
    
    enum Status: String, Codable {
        case active = "ACTIVE"
        case blocked = "BLOCKED"
        case deleted = "DELETED"
    }
    
    init(users: [Int], messages: [String], status: Status, organization: String) {
        self.users = users
        self.messages = messages
        self.status = status
        self.organization = organization
    }
}

class Swap: Codable {
    var bookTitle: String
    var image: String
    
    init(bookTitle: String, image: String) {
        self.bookTitle = bookTitle
        self.image = image
    }
}

class Giveaway: Codable {
    var user: String
    var userLocation: String?
    var address: Address
    var requests: Int
    var image: String
    var description: String
    var genre: [String]
    var isSwapped: Bool
    
    init(user: String, userLocation: String?, address: Address, requests: Int, image: String, description: String, genre: [String], isSwapped: Bool) {
        self.user = user
        self.userLocation = userLocation
        self.address = address
        self.requests = requests
        self.image = image
        self.description = description
        self.genre = genre
        self.isSwapped = isSwapped
    }
}

class SwapSlider: Codable {
    var image: String
    
    init(image: String) {
        self.image = image
    }
}

class Quiz
{
    var numberOfQuestion: Int
    var answers: [QuizAnswer]
    var ques: QuizQuestion
    var description: String
    var quizImage: UIImage
    
    init(numberOfQuestion: Int, answers: [QuizAnswer], ques: QuizQuestion, description: String, quizImage: UIImage) {
        self.numberOfQuestion = numberOfQuestion
        self.answers = answers
        self.ques = ques
        self.description = description
        self.quizImage = quizImage
    }
}
class QuizAnswer {
    var id = UUID()
    var text: String
    var isCorrect: Bool
    
    init(text: String, isCorrect: Bool) {
        self.text = text
        self.isCorrect = isCorrect
    }
}

class QuizQuestion {
    var question: String
    var correctAnswer: String
    var incorrectAnswers: [String]
    var category: String
    
    init(question: String, correctAnswer: String, incorrectAnswers: [String], category: String) {
        self.question = question
        self.correctAnswer = correctAnswer
        self.incorrectAnswers = incorrectAnswers
        self.category = category
    }
}

enum Genre: String, Codable {
    case Horror
    case Mystery
    case Fiction
    case Finance
    case Fantasy
    case Business
    case Romance
    case Psychology
    case YoungAdult = "YoungAdult"
    case SelfHelp = "SelfHelp"
    case HistoricalFiction = "HistoricalFiction"
    case NonFiction = "NonFiction"
    case ScienceFiction = "ScienceFiction"
}

class CurrentUser {
    
    var email: String
    var username: String
    var safeEmail: String
    {
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }

    
    init(email: String, username: String) {
        self.email = email
        self.username = username
        
    }
    
}
    
    
    

