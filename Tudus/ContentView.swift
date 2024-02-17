//
//  ContentView.swift
//  Tudus
//
//  Created by Daniil Malewicz on 2/13/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var userInput = ""
    @State private var items: [Item] = []
    
    var body: some View {
        VStack {
            TextField("Enter item", text: $userInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Add Item") {
                addItem()
            }
            .padding()
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(todo: userInput)
            modelContext.insert(newItem)
            items.append(newItem)
            userInput = ""
        }
    }
    
    private func deleteItem(_ item: Item) {
        withAnimation {
            if let index = items.firstIndex(of: item) {
                modelContext.delete(items[index])
                items.remove(at: index)
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
                items.remove(at: index)
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
