//
//  ObservableArray.swift
//  AutismExplainer
//
//  Created by Xander Smeets on 16/03/2025.
//


import SwiftUI
import Combine

@propertyWrapper
class ObservableArray<Element: ObservableObject>: DynamicProperty, ObservableObject {
    @State private var storage: [Element]
    private var cancellables: Set<AnyCancellable> = []

    var wrappedValue: [Element] {
        get { storage }
        set {
            storage = newValue
            observeElements()
        }
    }

    init(wrappedValue: [Element]) {
        self._storage = State(initialValue: wrappedValue)
        observeElements()
    }

    private func observeElements() {
        cancellables.removeAll()
        for element in storage {
            element.objectWillChange
                .sink { [weak self] _ in self?.objectWillChange.send() }
                .store(in: &cancellables)
        }
    }

    let objectWillChange = ObservableObjectPublisher()
}
