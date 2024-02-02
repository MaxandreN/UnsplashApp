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

struct ContentView: View {
    @State var imageList: [UnsplashPhoto] = []
    @StateObject var feedState = FeedState()
    
    // Déclaration d'une fonction asynchrone
    func loadData() async {
        await feedState.fetchHomeFeed()
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
