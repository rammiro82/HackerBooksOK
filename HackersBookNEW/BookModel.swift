//
//  BookModel.swift
//  HackerBooks
//
//  Created by Ramiro García Salazar on 11/12/15.
//  Copyright © 2015 Ramiro García Salazar. All rights reserved.
//

import UIKit


class Book: Equatable, Comparable{
    
    static let STR_BOOK_FAVOURITE: String = "_Favourite"
    
    
    //MARK: - Properties
    let title : String
    let authors : [String]
    var tags    : [String]
    var urlImage: NSURL
    var urlPDF  : NSURL
    
    var isFavorite : Bool {
        get{
            guard tags.count == 0 else{
                return tags.contains(Book.STR_BOOK_FAVOURITE)
            }
            return false
        }
    }
    
    //MARK: - Init
    init(title : String,
        authors : [String],
        tags    : [String],
        urlImage: NSURL,
        urlPDF  : NSURL){
        
            self.title      = title
            self.authors    = authors
            self.tags       = tags
            self.urlImage   = urlImage
            self.urlPDF     = urlPDF
    }
    
    
    //MARK: - Proxies

    
}

extension Book: CustomStringConvertible{
    var description: String{
        get{
            if title != "" {
                return "<\(self.dynamicType): \(title)>"
            }else{
                return "<\(self.dynamicType)>"
            }
        }
    }
}

//MARK: - Operators
func == (lhs: Book, rhs: Book) -> Bool{
    //son el mismo objeto
    guard !(lhs === rhs) else{
        return true
    }
    
    // Caso genérico
    return (lhs.title == rhs.title)
}

func < (lhs: Book, rhs: Book) -> Bool{
    return (lhs.title < rhs.title)
}