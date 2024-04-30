//
//  FirestoreOperation.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 29/04/24.
//

import FirebaseCore
import FirebaseFirestore
import Foundation

typealias FirestoreCompletion<D: Decodable> = (Result<D, FirestoreError>) -> Void

class FirestoreOperation {
    private static var currentTask: Task<Void, Never>?
    
    static func fetchFirestoreData<D: Decodable>(
        fromDocumentPath documentPath: String,
        completion: @escaping FirestoreCompletion<D>
    ) {
        currentTask?.cancel()
        
        currentTask = Task {
            do {
                let documentRef = Firestore.firestore().document(documentPath)
                
                let documentSnapshot: DocumentSnapshot = try await documentRef.getDocument()
                
                guard documentSnapshot.exists else {
                    completion(.failure(.notFound))
                    return
                }
                
                guard let documentData = documentSnapshot.data() else {
                    completion(.failure(.emptyData))
                    return
                }
                
                guard let decodedData = try? Firestore.Decoder().decode(D.self, from: documentData) else {
                    completion(.failure(.dataCorrupted))
                    return
                }
                
                completion(.success(decodedData))
            } catch {
                if let firestoreError = error as? FirestoreError {
                    completion(.failure(firestoreError))
                } else {
                    completion(.failure(.notFound))
                }
            }
        }
    }
}
