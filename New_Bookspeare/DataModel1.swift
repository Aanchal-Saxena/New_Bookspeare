//
//  DataModel1.swift
//  New_Bookspeare
//
//  Created by Sahil Raj on 05/06/24.
//

import Foundation
// Follower model for user connections
struct Follower: Codable {
    var name: String
    var contact: String
}

// BookClub model for user book clubs
struct BookClub: Codable {
    var name: String
    var image: String
    var genre: String
}

struct Address: Codable {
    var line1: String
    var countryCode: Int
    var city: String
    var state: String
}

struct BookShelf {
    var imageName: String
    var text: String
    var hooked: String
}

// User model for user data
struct Users: Codable {
//    var userId: Int
    var firstName: String
    var lastName: String
    var email: String
//    var followers: [Follower]
//    var following: [Follower]
//    var bookclubs: [BookClub]
    var image: String
//    var address: Address
//    var registeredEvents: [String]
//    var membershipRequests: [String]
}

// Event model for event details
struct Event: Codable {
    let title: String
    let images: String
//    let description: String
//    let attendees: [Int]?
//    let location: String?
//    let latitude: Double?
//    let longitude: Double?
//    let recurring: Bool
//    let isRecurringEventException: Bool
//    let isBaseRecurringEvent: Bool
//    let recurrenceRuleId: String?
//    let baseRecurringEventId: String?
//    let allDay: Bool
//    let startDate: Date
//    let endDate: Date?
//    let startTime: Date?
//    let endTime: Date?
//    let isPublic: Bool
//    let isRegisterable: Bool
//    let creatorId: Int
//    let admins: [Int]
//    let organization: String
//    let volunteerGroups: [String]
}

struct EventFilter: Codable
{
    var eventFilterButton : String
}

struct BookclubFilter: Codable
{
    var bookclubFilterButton : String
}


// GroupChat model for group chat details
struct GroupChat: Codable {
    let name: String
    let profile: String
//    let users: [Int]
//    let messages: [String]
//    let creatorId: Int
//    let organization: String
//    let status: Status
//
//    enum Status: String, Codable {
//        case active = "ACTIVE"
//        case blocked = "BLOCKED"
//        case deleted = "DELETED"
//    }
}

// DirectChat model for direct chat details
struct DirectChat: Codable {
    var users: [Int]
    var messages: [String]
    var status: Status
    var organization: String
    
    enum Status: String, Codable {
        case active = "ACTIVE"
        case blocked = "BLOCKED"
        case deleted = "DELETED"
    }
}

struct Swap: Codable
{
//    var user: String
    var bookTitle: String
//    var userLocation: String?
//    var requests: Int
    var image: String
//    var description: String
//    var genre: [String]
//    var isSwapped: Bool
}

struct Giveaway: Codable
{
    var user: String
    var userLocation: String?
    var address: Address
    var requests: Int
    var image: String
    var description: String
    var genre: [String]
    var isSwapped: Bool
}

struct SwapSlider: Codable
{
    var image: String
}

struct QuizAnswer
{
    var id = UUID()
    var text: String
    var isCorrect: Bool
}

struct QuizQuestion
{
    var question: String
    var correctAnswer: String
    var incorrectAnswers: [String]
    var category: String
}


