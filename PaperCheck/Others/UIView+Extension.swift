//
//  UIView+Extension.swift
//  PaperCheck
//
//  Created by Luiz Sena on 15/05/24.
//

import UIKit

protocol ViewCode {
    func setConstraints()
    func setConfig()
}

extension ViewCode {
    func loadViewCode(fromRoot view: UIView, branches components: [UIView]) {
        view.setSubviews(components)
        setConstraints()
        setConfig()
    }
}

extension UIView {
    func setSubviews(_ views: [UIView]) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
    }
}

