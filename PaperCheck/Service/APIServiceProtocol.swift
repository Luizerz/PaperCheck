//
//  APIServiceProtocol.swift
//  PaperCheck
//
//  Created by Luiz Sena on 15/05/24.
//

import Foundation
import Combine

protocol NoticesServiceType {
    func getNotices() -> AnyPublisher<Notice, Error>
}
