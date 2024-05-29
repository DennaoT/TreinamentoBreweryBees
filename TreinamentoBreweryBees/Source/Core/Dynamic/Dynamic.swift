//
//  Dynamic.swift
//  TreinamentoBreweryBees
//
//  Created by Dennis Torres on 04/04/24.
//

import Foundation

public class Dynamic<T> {
    typealias Listener = (T) -> Void
    
    // Armazenar a lista de observadores
    private var listeners: [Listener] = []
    
    // Valor dinâmico
    var value: T {
        didSet {
            // Notificar todos os observadores quando o valor é definido
            listeners.forEach { listener in
                listener(value)
            }
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    // Adicionar um observador
    func bind(listener: @escaping Listener) {
        listeners.append(listener)
        // Chamar o observador imediatamente quando é adicionado
        listener(value)
    }
}
