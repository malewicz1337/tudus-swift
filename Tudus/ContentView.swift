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
    
    var columns: [GridItem] {
        [GridItem(.flexible(minimum: 100, maximum: .infinity))]
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.cyan, .blue]),
                           startPoint: .bottomLeading,
                           endPoint: .topTrailing)
                .ignoresSafeArea(.all)
            VStack {
                Image("cat")
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(1, contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .padding(.top, 10)
                VStack {
                    TextField("Wine", text: $userInput)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.blue, lineWidth: 1)
                        )
                        .shadow(radius: 3)
                        .padding(.init(top: 30, leading: 50, bottom: 5, trailing: 50))
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .autocorrectionDisabled()
                    
                    Button(action: {
                        addItem()
                    }) {
                        HStack {
                            Text("Add")
//                                .font(.subheadline)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding(12)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .font(.headline)
                        .cornerRadius(10)
                        .shadow(radius: 3)
                    }
                    .padding(.init(top: 5, leading: 50, bottom: 15, trailing: 50))
                }
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(items, id: \.self) { item in
                            Button(action: {
                                deleteItem(item)
                            }) { HStack {
                                Text(item.todo)
                                    .lineLimit(nil)
                                    .padding()
                                    .foregroundStyle(.black)
                            }
                            
                            .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.blue, lineWidth: 1)
                            )
                            .shadow(radius: 3)
                            }
                            .padding(.init(top: 0, leading: 50, bottom: 0, trailing: 50))
                        }
                    }
                    .animation(.default, value: items)
                }
                .scrollIndicators(.hidden)
                .padding(.bottom, 7)
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
