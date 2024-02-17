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
    
    let columns = [GridItem(.adaptive(minimum: 100))]
//    let columns = [GridItem(.fixed(150))]
    
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.cyan, .blue]),
                           startPoint: .bottomLeading,
                           endPoint: .topTrailing)
            .ignoresSafeArea(.all)
            VStack {
                TextField("Enter item", text: $userInput)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 1)
                    )
                    .shadow(radius: 3)
                    .padding(.init(top: 30, leading: 50, bottom: 15, trailing: 50))
                    .font(.body)
                    .multilineTextAlignment(.center)
                
                Button("Add Item") {
                    addItem()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .font(.headline)
                .cornerRadius(10)
                .shadow(radius: 5)
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(items, id: \.self) { item in
                            Button(action: {
                                deleteItem(item)
                            }) {
                                Text(item.todo)
                                    .lineLimit(nil)
                                    .padding()
                                    .frame(maxWidth: .infinity, minHeight: 50)
                                    .background(Color.white)
                                    .cornerRadius(10)
                            }
                            .padding(5)
                        }
                    }
                }
            }
        }
    }
    
    private func addItem() {
        withAnimation {
            let trimmedInput = userInput.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if !trimmedInput.isEmpty {
                let newItem = Item(todo: trimmedInput)
                modelContext.insert(newItem)
                items.append(newItem)
            }
            
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
