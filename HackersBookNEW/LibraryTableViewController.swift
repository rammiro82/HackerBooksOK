//
//  LibraryTableViewController.swift
//  HackersBookNEW
//
//  Created by Ramiro García Salazar on 13/12/15.
//  Copyright © 2015 Ramiro García Salazar. All rights reserved.
//

import UIKit

class LibraryTableViewController: UITableViewController {
    
    var biblioteca : Library?
    
    func loadData(){
        
        do{
            if let url = NSURL(string: Library.URL_JSON),
                data = NSData(contentsOfURL: url),
                libros = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? JSONArray
            {
                biblioteca = Library(books: decode(bookArray: libros))
                
                print("countBooks -> \(biblioteca?.countBooks)")
                print("bookCountForTag -> \(biblioteca?.bookCountForTag("data mining"))")
                print("booksForTag -> \(biblioteca?.booksForTag("data mining"))")
                print("countBooks -> \(biblioteca?.countBooks)")
                
            }
        }catch{
            print("Error: Parseando el JSON")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return biblioteca!.countTags
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return biblioteca!.bookCountForTag(biblioteca!.tags[section])
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return biblioteca!.tags[section]
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let tag = self.biblioteca!.tags[indexPath.section]
        let booksForTag = self.biblioteca!.booksForTag(tag)
        let book = booksForTag?[indexPath.row]
        
        let cellID = "bookCellId"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as! BookTableViewCell
        
        cell.lblTitle.text = book?.title
        cell.lblAuthors.text = book?.authors.joinWithSeparator(", ")
        
        if let data = NSData(contentsOfURL: (book?.urlImage)!){
            cell.bookImage.image = UIImage(data: data)
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 50.0
    }

    
    // MARK: - Segues
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "pdfWebView" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                let tag = self.biblioteca!.tags[indexPath.section]
                let booksForTag = self.biblioteca!.booksForTag(tag)
                let book = booksForTag?[indexPath.row]
                
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! PDFViewController
                controller.bookDetail = book
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
