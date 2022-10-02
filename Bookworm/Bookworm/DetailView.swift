//
//  DetailView.swift
//  Bookworm
//
//  Created by Tony Capelli on 02/10/22.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var showingAlert = false
    
    let book: Book
    
    var body: some View {
        VStack {
            ScrollView{
                ZStack(alignment: .bottomTrailing){
                    Image(book.genre ?? "Fantasy")
                        .resizable()
                        .scaledToFit()
                    
                    Text(book.genre?.uppercased() ?? "FANTASY")
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(.black)
                        .clipShape(Capsule())
                        .offset(x:-5, y:-5)
                }
                
                Text(book.author ?? "Unknown Author")
                    .font(.title)
                
                Text(book.review ?? "no review")
                    .padding()
                
                Text(book.date?.formatted(date: .abbreviated, time: .omitted) ?? "no date")
            }
            Spacer()
            
            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
            
        }
        .navigationTitle(book.title ?? "Unknown title")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete the book",isPresented: $showingAlert){
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Calncer", role: .cancel){}
        } message: {
            Text("Are you sure you want to delete the book?")
        }
        .toolbar{
            Button{
                showingAlert = true
            } label: {
                Label("Delete book", systemImage: "trash")
            }
            
        }
    }
    
    func deleteBook() {
        moc.delete(book)
        
        try? moc.save()
        dismiss()
    }
}

