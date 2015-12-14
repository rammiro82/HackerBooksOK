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
    
    var bookDetail: Book?
    
    func configureView() {
        // Update the user interface for the detail item.
        do{
            if bookDetail != nil {
                let request = NSURLRequest(URL: (bookDetail?.urlPDF)!)
                pdfWebView.loadRequest(request)
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
}
