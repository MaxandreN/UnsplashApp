//
//  UnsplashAPI.swift
//  UnsplashApp
//
//  Created by Maxandre Neveux on 02/02/2024.
//

import SwiftUI

// Construit un objet URLComponents avec la base de l'API Unsplash
// Et un query item "client_id" avec la clé d'API retrouvé depuis PListManager
struct UnsplashAPI {
    let scheme : String = "https"
    let host : String = "api.unsplash.com"
    let path : String = "/photos"
    
    func unsplashApiBaseUrl() -> URLComponents {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.queryItems = [
            URLQueryItem(name: "client_id", value: ConfigurationManager.instance.plistDictionnary.clientId),
        ]
        return components
    }
    
    // Par défaut orderBy = "popular" et perPage = 10 -> Lisez la documentation de l'API pour comprendre les paramètres, vous pouvez aussi en ajouter d'autres si vous le souhaitez
    func feedUrl(orderBy: String = "popular", perPage: Int = 10) -> URL? {
        var components = unsplashApiBaseUrl()
        components.path = "/photos"
        components.queryItems! += [
            URLQueryItem(name: "order_by", value: orderBy),
            URLQueryItem(name: "per_page", value: String(perPage)),
        ]
        
        return components.url
    }
    
    func getTopics() -> URL? {
        var components = unsplashApiBaseUrl()
        components.path = "/topics"
        components.queryItems! += [
            URLQueryItem(name: "order_by", value: "featured"),
            URLQueryItem(name: "per_page", value: String(3)),
        ]
        
        return components.url
        
    }
}


