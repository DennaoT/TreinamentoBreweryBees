//
//  ImageDownloadOperation.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 29/05/24.
//

import UIKit

protocol ImageDownloadable {
    static func fetchImage(fromURL urlString: String?, completion: @escaping (UIImage?) -> Void)
}

class ImageDownloadOperation: ImageDownloadable {
    static func fetchImage(
        fromURL urlString: String?,
        completion: @escaping (UIImage?) -> Void
    ) {
        Task {
            guard let urlString = urlString,
                  let url = URL(string: urlString) else {
                completion(nil)
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    if let image = UIImage(data: data) {
                        completion(image)
                    } else {
                        completion(nil)
                    }
                }
            }.resume()
        }
    }
}
