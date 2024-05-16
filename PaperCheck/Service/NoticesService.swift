//
//  API.swift
//  PaperCheck
//
//  Created by Luiz Sena on 14/05/24.
//

import Foundation
import Combine

struct NoticesService: NoticesServiceType {
    func getNotices() -> AnyPublisher<Notice, any Error> {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apikey=27920c5f2a8e4371b094ad9b17ce4bb9")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .catch { error in
                return Fail(error: error).eraseToAnyPublisher()
            } .map({$0.data})
            .decode(type: Notice.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

}
