//
//  JSONProcesing.swift
//  HackerBooks
//
//  Created by Ramiro García Salazar on 12/12/15.
//  Copyright © 2015 Ramiro García Salazar. All rights reserved.
//

import UIKit

/*
{
    "authors": "Jeff Heard, Anand Rajaraman, Stefane Laborde",
    "image_url": "http://hackershelf.com/media/cache/06/df/06df282659657e529d8111e08aa79274.jpg",
    "pdf_url": "http://infolab.stanford.edu/~ullman/mmds/book.pdf",
    "tags": "data mining, text processing",
    "title": "Mining of Massive Datasets"
}
*/


//MARK: - Claves
enum JSONKeys: String{
    case authors = "authors"
    case imageUrl  = "image_url"
    case pdfUrl = "pdf_url"
    case tags = "tags"
    case title = "title"
}

//MARK: - Aliases
typealias JSONObject        = AnyObject
typealias JSONDictionary    = [String:JSONObject]
typealias JSONArray         = [JSONDictionary]

//MARK: - Errors
enum JSONProcessingError : ErrorType{
    case WrongURLFormatForJSONResource
    case ResourcePointedByURLNotReachable
    case JSONParsingError
    case WrongJSONFormat
}


//MARK: - Decoding
func decode(book json: JSONDictionary) throws -> Book{
    
    let authors   = json[JSONKeys.authors.rawValue] as! String
    
    // Nos metemos en el mundo imaginario de Yupi donde todo funciona y nada es nil
    guard let urlStringImage = json[JSONKeys.imageUrl.rawValue] as? String,
        imageUrl = NSURL(string: urlStringImage) else{
            throw JSONProcessingError.WrongURLFormatForJSONResource
    }
    
    guard let urlStringPdf = json[JSONKeys.pdfUrl.rawValue] as? String,
         pdfUrl = NSURL(string: urlStringPdf) else{
            throw JSONProcessingError.WrongURLFormatForJSONResource
    }
    
    // Estamos en el mundo de Yupi: todo es fabuloso.
    let tags    = json[JSONKeys.tags.rawValue] as! String
    let title   = json[JSONKeys.title.rawValue] as! String
    
    let authorsArr = clearWhiteSpaces(arrayOfStrings: authors.characters.split(",").map(String.init))
    let tagsArr = clearWhiteSpaces(arrayOfStrings: tags.characters.split(",").map(String.init))
    
    return Book(title: title,
        authors: authorsArr,
        tags: tagsArr,
        urlImage: imageUrl,
        urlPDF: pdfUrl)
}

func clearWhiteSpaces(arrayOfStrings arrayStr: [String]) -> [String] {
    var result : [String] = [String]()
    for str in arrayStr{
        result.append(str.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()))
    }
    return result
}

func decode(bookArray json: JSONArray) -> [Book]{
    var resultado = [Book]()
    
    do{
        for entrada in json{
            let aux = try decode(book: entrada)
            
            resultado.append(aux)
        }
        
    }catch{
        fatalError("Error procesando el array de libros.")
    }
    
    return resultado
}















