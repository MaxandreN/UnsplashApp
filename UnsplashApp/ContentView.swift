//
//  ContentView.swift
//  UnsplashApp
//
//  Created by Maxandre Neveux on 02/02/2024.
//

import SwiftUI

let columns = [
    GridItem(.flexible()),
    GridItem(.flexible())
]

let columnsTopics = [
    GridItem(.flexible()),
    GridItem(.flexible()),
    GridItem(.flexible())
]

struct ContentView: View {
    @State var imageList: [UnsplashPhoto] = []
    @StateObject var feedState = FeedState()
    
    // Déclaration d'une fonction asynchrone
    func loadData() async {
        await feedState.fetchHomeFeed()
        await feedState.fetchTopicsFeed()
    }
    
    var body: some View {
        NavigationStack{
            VStack {
                // le bouton va lancer l'appel réseau
                Button(action: {
                    Task {
                        await loadData()
                    }
                }, label: {
                    Text("Load Data")
                })
                ScrollView(.horizontal) {
                    HStack{
                            if feedState.topicsFeed != nil {
                                ForEach(feedState.topicsFeed!, id: \.self.id) { item in
                                    VStack{
                                        AsyncImage(url: URL(string: item.cover_photo.urls.small)) { image in
                                            image.resizable()
                                        } placeholder: {
                                            ProgressView()
                                        }.frame(width: 120, height: 60)
                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                        Text(item.slug)
                                    }
                                }
                            } else {
                                // Use a placeholder when data is not available
                                ForEach(0..<3, id: \.self) { _ in
                                    RoundedRectangle(cornerRadius: 12.0)
                                        .frame(width: 120, height: 60)
                                        .foregroundStyle(.placeholder)
                                }
                            }
                    }.padding(.vertical)
                    
                }
                    
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 8) {
                        if feedState.homeFeed != nil {
                            ForEach(feedState.homeFeed!, id: \.self.id) { item in
                                AsyncImage(url: URL(string: item.urls.small)) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }.frame(height: 150)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                            }
                        } else {
                            // Use a placeholder when data is not available
                            ForEach(0..<12, id: \.self) { _ in
                                RoundedRectangle(cornerRadius: 12.0)
                                    .frame(height: 150)
                                    .foregroundStyle(.placeholder)
                            }
                        }
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal)
                .navigationTitle("Feed")
            }
        }
    }
}

#Preview {
    ContentView()
}
