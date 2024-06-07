//
//  DataModel1.swift
//  New_Bookspeare
//
//  Created by Sahil Raj on 05/06/24.
//

import Foundation
import UIKit

// Follower model for user connections
class Follower: Codable {
    var name: String
    var contact: String
    
    init(name: String, contact: String) {
        self.name = name
        self.contact = contact
    }
}

// BookClub model for user book clubs
class BookClub: Codable {
    var name: String
    var image: String
    var genre: String
    var description: String
    var members: Int
    
    init(name: String, image: String, genre: String, description: String, members: Int) {
        self.name = name
        self.image = image
        self.genre = genre
        self.description = description
        self.members = members
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

struct BookShelf {
    var imageName: String
    var text: String
    var hooked: String
}

// User model for user data
class User: Codable {
    var firstName: String
    var lastName: String
    var email: String
    var pronouns: String
    var bookclubs: [BookClub]
    var image: String
    var userGenres: [Genre]
    var bio: String
    
    init(firstName: String, lastName: String, email: String, pronouns: String, bookclubs: [BookClub], image: String, userGenres: [Genre], bio: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.pronouns = pronouns
        self.bookclubs = bookclubs
        self.image = image
        self.userGenres = userGenres
        self.bio = bio
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
    


