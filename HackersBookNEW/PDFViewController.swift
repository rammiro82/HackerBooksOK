//
//  PDFViewController.swift
//  HackersBookNEW
//
//  Created by Ramiro García Salazar on 14/12/15.
//  Copyright © 2015 Ramiro García Salazar. All rights reserved.
//

import UIKit

class PDFViewController: UIViewController {
    @IBOutlet weak var pdfWebView: UIWebView!
    
    @IBOutlet weak var favButton: DOFavoriteButton!
    
    
    var bookDetail: Book?
    
    func configureView() {
        // Update the user interface for the detail item.
        do{
            
            favButton.addTarget(self, action: Selector("tapped:"), forControlEvents: .TouchUpInside)
            
            if bookDetail != nil {
                let request = NSURLRequest(URL: (bookDetail?.urlPDF)!)
                pdfWebView.loadRequest(request)
                
                if (bookDetail!.isFavorite) {
                    favButton.select()
                }else{
                    favButton.deselect()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setTagFavourite (isFavourite: Bool){
        if isFavourite {
            bookDetail?.tags.append(Book.STR_BOOK_FAVOURITE)
        }else{
            bookDetail?.tags.removeAtIndex((bookDetail?.tags.indexOf(Book.STR_BOOK_FAVOURITE))!)
        }
    }
    
    
    func tapped(sender: DOFavoriteButton) {
        if sender.selected {
            // deselect
            sender.deselect()
            //setTagFavourite(false)
        } else {
            // select with animation
            sender.select()
            //setTagFavourite(true)
        }
    }
}
