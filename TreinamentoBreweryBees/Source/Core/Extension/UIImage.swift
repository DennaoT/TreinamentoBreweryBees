//
//  UIImage.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 15/04/24.
//

import UIKit

public enum URLImages: String {
    
    // MARK: - Home Features Images
    
    case apiExample = "https://cdn-icons-png.flaticon.com/512/2164/2164832.png"
    case marvel = "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b9/Marvel_Logo.svg/1600px-Marvel_Logo.svg.png"
    case loginFB = "https://static.javatpoint.com/tutorial/firebase/images/firebase-authentication.png"
    case components = "https://static.vecteezy.com/system/resources/previews/007/091/621/non_2x/colored-line-icons-set-in-flat-design-education-school-collection-of-modern-pictograms-and-university-with-elements-for-mobile-concepts-and-web-apps-vector.jpg"
}

public extension UIImage {
    static func loadFromURL(urlString: String?) -> UIImage? {
        guard let urlString = urlString,
              let url = URL(string: urlString),
              let data = try? Data(contentsOf: url),
              let image = UIImage(data: data) else {
            return nil
        }
        return image
    }
}
