//
//  FirestoreOperation.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 29/04/24.
//

import FirebaseCore
import FirebaseFirestore
import Foundation
import Reachability

typealias FirestoreCompletion<D: Decodable> = (Result<D, Error>) -> Void

protocol FirestoreOperable {
    static func fetchFirestoreData<D: Decodable>(fromDocumentPath documentPath: String, completion: @escaping FirestoreCompletion<D>)
}

class FirestoreOperation: FirestoreOperable {
    private static var currentTask: Task<Void, Never>?
    
    static func fetchFirestoreData<D: Decodable>(
        fromDocumentPath documentPath: String,
        completion: @escaping FirestoreCompletion<D>
    ) {
        currentTask?.cancel()
        
        guard let reachability = try? Reachability(),
              reachability.connection != .unavailable else {
            completion(.failure(InternetError.noConnection))
            return
        }
        
        currentTask = Task {
            do {
                let documentRef = Firestore.firestore().document(documentPath)
                
                let documentSnapshot: DocumentSnapshot = try await documentRef.getDocument()
                
                guard documentSnapshot.exists else {
                    completion(.failure(FirestoreError.notFound))
                    return
                }
                
                guard let documentData = documentSnapshot.data() else {
                    completion(.failure(FirestoreError.emptyData))
                    return
                }
                
                guard let decodedData = try? Firestore.Decoder().decode(D.self, from: documentData) else {
                    completion(.failure(FirestoreError.dataCorrupted))
                    return
                }
                
                completion(.success(decodedData))
            } catch {
                switch error {
                case let firestoreError as FirestoreError:
                    completion(.failure(firestoreError))
                case let internetError as InternetError:
                    completion(.failure(internetError))
                default:
                    completion(.failure(error))
                }
            }
        }
    }
}
