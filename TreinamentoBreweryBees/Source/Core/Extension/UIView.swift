//
//  UIView.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 29/05/24.
//

import UIKit
import SnapKit

extension UIView {
    static func getLineDivisor(height: CGFloat = 1.5) -> UIView {
        let lineDivisor = UIView()
        lineDivisor.translatesAutoresizingMaskIntoConstraints = false
        lineDivisor.backgroundColor = UIColor(hex: "#D8D8D8")
        lineDivisor.snp.makeConstraints { make in
            make.height.equalTo(height)
        }
        return lineDivisor
    }
    
    static func getUnfocusedView(isUserInteractionEnabled: Bool = false) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black.withAlphaComponent(0.45)
        view.isUserInteractionEnabled = isUserInteractionEnabled
        return view
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach { subview in
            addSubview(subview)
        }
    }
    
    func removeSubviews() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
}
