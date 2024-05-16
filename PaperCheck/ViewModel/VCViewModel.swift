//
//  VCViewModel.swift
//  PaperCheck
//
//  Created by Luiz Sena on 15/05/24.
//

import Foundation
import Combine

class VCViewModel {

    enum Input {
        case viewDidAppear
    }
    enum Output {
        case fetchNoticesDidFail(error: Error)
        case fetchNoticesDidSucceed(data: NoticeEntity)
    }

    private let service: NoticesServiceType
    private let output: PassthroughSubject<Output, Never> = .init()
    private var cancellables =  Set<AnyCancellable>()

    init(service: NoticesServiceType = NoticesService()) {
        self.service = service
    }

    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        input.sink { [weak self] event in
            switch event {
            case .viewDidAppear:
                self?.handleGetNotices()
            }
        }
        .store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }

    private func handleGetNotices() {
        service.getNotices().sink { [weak self] completion in
            if case .failure(let error) = completion {
                self?.output.send(.fetchNoticesDidFail(error: error))
            }
        } receiveValue: { [weak self] notice in
            self?.output.send(.fetchNoticesDidSucceed(data: NoticeEntity(notice: notice)))
        }
        .store(in: &cancellables)
    }

}
