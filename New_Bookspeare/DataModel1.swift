//
//  DataModel1.swift
//  New_Bookspeare
//
//  Created by Sahil Raj on 05/06/24.
//

import Foundation
import UIKit
import SwiftUI
import Firebase


extension Array {
    func compactMap<T>(_ transform: (Element) throws -> T?) rethrows -> [T] {
        var result: [T] = []
        for element in self {
            if let transformed = try transform(element) {
                result.append(transformed)
            }
        }
        return result
    }
}



struct Friend: Codable {
    var name: String
    var email: String
    var id: UUID
    var profile: String?
    
    func toDictionary() -> [String: Any] {
        return [
            "name": name,
            "email": email,
            "id": id.uuidString,
            "profile": profile ?? ""
        ]
    }
}

struct BookClub: Codable {
    var id: UUID = UUID()
    var name: String
    var image: String
    var description: String?
    var members: Int?
    var admin: String?
    
    func toDictionary() -> [String: Any] {
        return [
            "id": id.uuidString,
            "name": name,
            "image": image,
            "description": description ?? "",
            "members": members ?? 1,
            "admin": admin ?? ""
        ]
    }
    init(id: UUID, name: String, image: String, description: String? = nil, members: Int? = nil, admin: String? = nil) {
        self.id = id
        self.name = name
        self.image = image
        self.description = description
        self.members = members
        self.admin = admin
    }
}


struct User: Codable {
    var id: UUID
    var username: String?
    var name: String?
    var email: String
    var pronouns: String?
    var bookclubs: [BookClub]?
    var image: String?
    var userGenres: [Genre]?
    var bio: String?
    var friends: [Friend]?
    var swappedBooks: [Swap]?
    
    var safeEmail: String {
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
    
    var profilePictureUrl: String {
        return "\(safeEmail)_profile_picture.png"
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
            "friends": friends?.map { $0.toDictionary() } ?? [],
            "swappedBooks": swappedBooks?.map { $0.toDictionary() } ?? []
        ]
    }
}

struct Location: Codable {
    var latitude: Double
    var longitude: Double
    
    func toDictionary() -> [String: Double] {
        return [
            "latitude": latitude,
            "longitude": longitude
        ]
    }
}

class Swap: Codable {
    var id = UUID()
    var bookTitle: String
    var description: String
    var location: Location
    var image: String
    
    init(id: UUID = UUID(), bookTitle: String, description: String, location: Location, image: String) {
        self.id = id
        self.bookTitle = bookTitle
        self.description = description
        self.location = location
        self.image = image
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "id": id.uuidString,
            "bookTitle": bookTitle,
            "description": description,
            "location": location.toDictionary(),
            "image": image
        ]
    }
}


class Event: Codable {
    var id = UUID()
    let title: String
    let images: String
    var description: String
    var registeredMembers: Int
    var address: String
    
    init(id: UUID = UUID(), title: String, images: String, description: String, registeredMembers: Int, address: String) {
        self.id = id
        self.title = title
        self.images = images
        self.description = description
        self.registeredMembers = registeredMembers
        self.address = address
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "id": id.uuidString,
            "title": title,
            "images": images,
            "description": description,
            "address": address,
            "registeredMembers": registeredMembers
        ]
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

class GroupChat: Codable {
    let name: String
    let profile: String
    
    init(name: String, profile: String) {
        self.name = name
        self.profile = profile
    }
}

struct Message: Identifiable, Codable {
    var id: String
    var text: String
    var received: Bool
    var timestamp: Date
}






class SwapSlider: Codable {
    var image: String
    
    init(image: String) {
        self.image = image
    }
}

class Quiz {
    var numberOfQuestion: Int
    var questions: [QuizQuestion]
    var description: String
    var quizImage: UIImage
    var name: String
    
    init(numberOfQuestion: Int, questions: [QuizQuestion], description: String, quizImage: UIImage, name: String) {
        self.numberOfQuestion = numberOfQuestion
        self.questions = questions
        self.description = description
        self.quizImage = quizImage
        self.name = name
    }
    
    func addQuestion(_ question: QuizQuestion) {
        self.questions.append(question)
    }
}

class QuizAnswer {
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

class Bookshelf: Codable
{
    var name: String
    var description: String
    var books: [Book]?
    var image: String
    
    init(name: String, description: String, books: [Book]? = nil, image: String) {
        self.name = name
        self.description = description
        self.books = books
        self.image = image
    }
    
    
    func toDictionary() -> [String: Any] {
            var dictionary: [String: Any] = [
                "name": name,
                "description": description,
            ]
            
            if let books = books {
                dictionary["books"] = books.map { $0.toDictionary() }
            } else {
                dictionary["books"] = nil
            }
            
            return dictionary
        }
}

class Book: Codable {
    var title: String
    var author: String
    var image: String
    var hooked: String
    
    init(title: String, author: String, image: String, hooked: String) {
        self.title = title
        self.author = author
        self.image = image
        self.hooked = hooked
    }
    
    func toDictionary() -> [String: Any] {
            return [
                "title": title,
                "author": author,
                "imageUrl": image,
                "hooked": hooked
            ]
        }
}
