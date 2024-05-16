//
//  ViewController.swift
//  PaperCheck
//
//  Created by Luiz Sena on 14/05/24.
//

import UIKit
import Combine

class ViewController: UIViewController, ViewCode {

    private let vm = VCViewModel()
    private let input: PassthroughSubject<VCViewModel.Input, Never> = .init()
    private var cancellables =  Set<AnyCancellable>()

    private var myLabel: UILabel = {
        let label = UILabel()
        label.text = "Nothin..."
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        loadViewCode(fromRoot: self.view, branches: [myLabel])
        self.bind()
    }

    override func viewDidAppear(_ animated: Bool) {
        input.send(.viewDidAppear)
    }

     func bind() {
        let output = vm.transform(input: input.eraseToAnyPublisher())
        output
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                switch result {
                case .fetchNoticesDidFail(let error):
                    print(error)
                case .fetchNoticesDidSucceed(let data):
                    self?.myLabel.text = data.articles[0].title
                }
            }.store(in: &cancellables)
    }

    func setConfig() {
        myLabel.numberOfLines = 2
        myLabel.textAlignment = .center
    }

    func setConstraints() {
        NSLayoutConstraint.activate([
            self.myLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.myLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            self.myLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.myLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

}

#Preview(body: {
    let vc = ViewController()
    return vc
})
