// ContentView.swift
// Bookworm
// Created by Bukhari Sani on 16/05/2023.

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    // The managed object context for Core Data, used for interacting with the database
    
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title),
        SortDescriptor(\.author)])
    var books: FetchedResults<Book>
    // Fetched results of books, sorted by title and author
    
    @State private var showingAddScreen = false
    // State variable to control the presentation of the AddBookView
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books) { book in
                    // Iterate over each book in the fetched results
                    
                    NavigationLink {
                        DetailView(book: book)
                        // Navigate to the detail view for the selected book
                    } label: {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                            // Display the book's rating as an emoji using the EmojiRatingView component
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading) {
                                Text(book.title ?? "Unknown Title")
                                // Display the book's title or "Unknown Title" if it's nil
                                    .font(.headline)
                                
                                Text(book.author ?? "Unknown Author")
                                // Display the book's author or "Unknown Author" if it's nil
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationTitle("Bookworm")
            // Set the navigation title to "Bookworm"
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddScreen.toggle()
                        // Toggle the state variable to control the presentation of the AddBookView
                    } label: {
                        Label("Add Book", systemImage: "plus")
                        // Display the "Add Book" button with a plus icon
                    }
                }
            }
            
            .sheet(isPresented: $showingAddScreen) {
                AddBookView()
                // Present the AddBookView as a sheet when showingAddScreen is true
            }
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            moc.delete(book)
        }
        //try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
