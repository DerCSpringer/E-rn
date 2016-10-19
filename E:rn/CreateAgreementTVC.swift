//
//  CreateAgreementTVC.swift
//  E:rn
//
//  Created by Daniel on 10/14/16.
//  Copyright © 2016 Daniel. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData

class CreateAgreementTVC: UITableViewController {
    @IBOutlet weak var cost: UITextField!
    @IBOutlet weak var toEarn: UITextField!
    @IBOutlet weak var parentName: UITextField!
    @IBOutlet weak var byDoingTask: UITextField!
    @IBOutlet weak var value: UITextField!
    let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


    var name : String?
    var earn : String?
    var costs : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        parentName.text = name
        cost.text = costs
        toEarn.text = earn

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Do Add Agreement" {

            let entity = NSEntityDescription.entity(forEntityName: "Agreement", in: moc)
            let agreement = NSManagedObject(entity: entity!, insertInto: moc)
            agreement.setValue(parentName.text!, forKey: "name")
            agreement.setValue(Date.init() as NSDate?, forKey: "date")
            agreement.setValue(toEarn.text!, forKey: "terms")
            agreement.setValue(cost.text!, forKey: "value")
            
            do {
                try moc.save()
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    }
    
    @IBAction func cancel()
    {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
