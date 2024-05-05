//
//  UIStackView.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 04/05/24.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { subview in
            addArrangedSubview(subview)
        }
    }
    
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { subview in
            addArrangedSubview(subview)
        }
    }
    
    func removeAllArrangedSubviews() {
        arrangedSubviews.forEach { subview in
            removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
    }
}
