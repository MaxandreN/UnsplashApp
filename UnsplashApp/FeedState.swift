//
//  FeedState.swift
//  UnsplashApp
//
//  Created by Maxandre Neveux on 02/02/2024.
//

import Foundation
import SwiftUI

struct UnsplashPhoto: Codable, Identifiable {
    let id: String
    let slug: String
    let author: User?
    let urls: UnsplashPhotoUrls
}

struct User: Codable {
    let name: String
}

struct UnsplashPhotoUrls: Codable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}

struct UnsplashTopic: Codable, Identifiable {
    let id: String
    let slug: String
    let owners: User?
    let photo: UnsplashPhoto
}

class FeedState: ObservableObject {
    @Published var homeFeed: [UnsplashPhoto]?
    @Published var topicsFeed: [UnsplashTopic]?

    func fetchHomeFeed() async {
        do {
            
            if let url = UnsplashAPI().feedUrl(){
                // Créez une requête avec cette URL
                let request = URLRequest(url: url)
                
                // Faites l'appel réseau
                let (data, _) = try await URLSession.shared.data(for: request)
                
                // Transformez les données en JSON
                let deserializedData = try JSONDecoder().decode([UnsplashPhoto].self, from: data)
                
                // Mettez à jour l'état de la vue
                homeFeed = deserializedData
            }

        } catch {
            print("Error: \(error)")
        }
    }
    
    func fetchTopicsFeed() async {
        do {
            
            if let url = UnsplashAPI().getTopics(){
                // Créez une requête avec cette URL
                let request = URLRequest(url: url)
                
                // Faites l'appel réseau
                let (data, _) = try await URLSession.shared.data(for: request)
                
                // Transformez les données en JSON
                let deserializedData = try JSONDecoder().decode([UnsplashTopic].self, from: data)
                
                // Mettez à jour l'état de la vue
                topicsFeed = deserializedData
                print(topicsFeed)
            }

        } catch {
            print("Error: \(error)")
        }
    }
    

}

#Preview {
    ContentView()
}
