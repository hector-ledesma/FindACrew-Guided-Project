//
//  PersonController.swift
//  FindACrew
//
//  Created by Karen Rodriguez on 3/10/20.
//  Copyright © 2020 Hector Ledesma. All rights reserved.
//

import Foundation

class PersonController {
    private(set) var people : [Person] = []
    
    func searchForPeopleWith(searchTerm: String, completion: @escaping () -> Void) {
        let baseURL = URL(string: "https://swapi.co/api/people")!
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchTermQueryItem = URLQueryItem(name: "search", value: searchTerm)
        urlComponents?.queryItems = [searchTermQueryItem]
        
        guard let requestURL = urlComponents?.url else {
            NSLog("request URL is nil")
            completion()
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion()
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from data task.")
                completion()
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let personSearch = try jsonDecoder.decode(PersonSearch.self, from: data)
                self.people.append(contentsOf: personSearch.results)
            } catch {
                NSLog("Unable to decode data into object of type [Person]: \(error)")
            }
            completion()
        }.resume()
    }
}
