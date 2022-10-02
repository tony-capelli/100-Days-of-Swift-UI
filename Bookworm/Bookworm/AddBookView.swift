//
//  AddBookView.swift
//  Bookworm
//
//  Created by Tony Capelli on 02/10/22.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Horror"
    @State private var review = ""
    
    let genres = ["Fantasy", "Horror", "Mistery", "Kids", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationView{
            Form{
                Section {
                    TextField("Enter name of book", text: $title)
                    TextField("Enter author's name", text: $author)
                    
                    Picker("Genre", selection: $genre){
                        ForEach(genres, id:\.self){
                            Text($0)
                        }
                    }
                }
                
                Section{
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                } header: {
                    Text("Wrtie a review")
                }
                
                Section{
                    Button("Save"){
                        let myNewBook = Book(context: moc)
                        myNewBook.id = UUID()
                        myNewBook.title = title
                        myNewBook.author = author
                        myNewBook.rating = Int16(rating)
                        myNewBook.genre = genre
                        myNewBook.review = review
                        myNewBook.date = Date.now
                        
                        try? moc.save()
                        dismiss()
                    }
                }
                .disabled(!isFormCorrect())
            }
            .navigationTitle("Add Book")
        }
    }
    func isFormCorrect()->Bool {
        if title.isEmpty || author.isEmpty || review.isEmpty || genre.isEmpty {
            return false
        } else {
            return true
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
