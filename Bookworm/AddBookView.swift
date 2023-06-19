//
//  AddBookView.swift
//  Bookworm
//
//  Created by Bukhari Sani on 18/06/2023.
//

import SwiftUI

struct AddBookView: View {
    // Access the managed object context to interact with Core Data
    @Environment(\.managedObjectContext) var moc
    
    // Access the dismiss action to close the view
    @Environment(\.dismiss) var dismiss
    
    // State properties to store user input
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    
    // Available genres for the book
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationView {
            Form {
                // Book Information Section
                Section {
                    // Text field for entering the name of the book
                    TextField("Name of book", text: $title)
                    
                    // Text field for entering the author's name
                    TextField("Author's name", text: $author)
                    
                    // Picker for selecting the genre of the book
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id:\.self) {
                            Text($0)
                        }
                    }
                }
                
                // Review Section
                Section {
                    // Text editor for writing a review of the book
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                    

                } header: {
                    // Header text for the review section
                    Text("Write a review")
                }
                
                // Save Button Section
                Section {
                    // Button for saving the book
                    Button("Save") {
                        // Creating a new instance of the Book entity
                        let newBook = Book(context: moc)
                        
                        // Assigning values to the properties of the new book
                        newBook.id = UUID()
                        newBook.title = title
                        newBook.author = author
                        newBook.rating = Int16(rating)
                        newBook.genre = genre
                        newBook.review = review
                        
                        // Saving the new book to the managed object context
                        try? moc.save()
                        
                        // Dismissing the view and returning to the previous screen
                        dismiss()
                    }
                }
            }
            .navigationTitle("Add Book")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
