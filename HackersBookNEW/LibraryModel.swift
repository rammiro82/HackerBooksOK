//
//  LibraryModel.swift
//  HackerBooks
//
//  Created by Ramiro García Salazar on 11/12/15.
//  Copyright © 2015 Ramiro García Salazar. All rights reserved.
//

import UIKit

class Library {
    //
    var books   : [Book]
    
    // diccionario de tags, donde la clave es el tag correspondiente y los valores array de Books
    var tags        : [String]
    var tagsBooks   : [String:[Book]]
    
    static let URL_JSON = "https://t.co/K9ziV0z3SJ"
    static let LOCAL_LIBRARY_DATA = "HackersBooks_local_data"
    
    var countBooks : Int {
        get{
            return self.books.count
        }
    }
    
    var countTags: Int{
        get{
            return self.tags.count
        }
    }
    
    init(){
        self.books      = [Book]()
        self.tags       = [String]()
        self.tagsBooks  = [String:[Book]]()
    }
    
    init(books: [Book]){
        
        tagsBooks = Dictionary<String, Array<Book>>()
        (self.tags,self.tagsBooks) = Library.procesarTags(books)
        
        self.books = books.sort({$0 < $1})
    }
    
    // Cantidad de libros que hay en una temática
    func bookCountForTag(tag: String) -> Int{
        guard tags.contains(tag) else{
            return 0
        }
        
        return books.filter({$0.tags.contains(tag)}).count
    }
    
    func booksForTag (tag: String) -> [Book]? {
        return tagsBooks[tag]
    }
    
    func bookAtIndex (tag: String, index: Int) -> Book?{
        var auxBooks = booksForTag(tag)
        
        guard (index >= 0) else{
            return auxBooks![index]
        }
        return nil
    }
    
    private static func procesarTags(books: [Book]) -> ([String], [String:[Book]]){
        var todasTags: [String] = []
        var auxTagsBooks: [String:[Book]] = Dictionary<String, Array<Book>>()
        
        for book in books{
            for tag in book.tags{
                //procesamos todos los tags de cada libro
                if(!todasTags.contains(tag)){
                    todasTags.append(tag)
                    auxTagsBooks[tag] = Array<Book>()
                }
                
                auxTagsBooks[tag]?.append(book)
            }
        }
        
        return (todasTags.sort({$0 < $1}), auxTagsBooks)
    }
}
