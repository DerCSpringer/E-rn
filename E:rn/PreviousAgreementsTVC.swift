//
//  PreviousAgreementsTVC.swift
//  E:rn
//
//  Created by Daniel on 10/15/16.
//  Copyright © 2016 Daniel. All rights reserved.
//

import UIKit
import CoreData

class PreviousAgreementsTVC: UITableViewController {
    
    let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeFetchedResultsController()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "agreements", for: indexPath)
        let agreement = fetchedResultsController.object(at: indexPath)
        cell.textLabel!.text = agreement.name!
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        
        cell.detailTextLabel?.text = dateFormatter.string(from: agreement.date! as Date)

        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections!.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {        guard let sections = fetchedResultsController.sections else {
            fatalError("No sections in fetchedResultsController")
        }
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }




    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {

            let cell = sender as! UITableViewCell
            let catvc = segue.destination as! CreateAgreementTVC
            let index = tableView.indexPath(for: cell)
            let agreement = fetchedResultsController.object(at: index!)
            print(agreement)
            
            //catvc.parentName.text = agreement.name?
            catvc.name = agreement.name!
            catvc.costs = "$" + agreement.value!
            catvc.earn = agreement.terms!
            //print (segue.destination)
        }
    }
 

    var fetchedResultsController: NSFetchedResultsController<Agreement>!
    
    func initializeFetchedResultsController() {
        let request: NSFetchRequest<Agreement> = Agreement.fetchRequest()
        let dateSort = NSSortDescriptor(key: "date", ascending: true)
        let nameSort = NSSortDescriptor(key: "name", ascending: true)

        request.sortDescriptors = [dateSort, nameSort]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request
        , managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)

        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }
    @IBAction func back()
    {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    

}

extension PreviousAgreementsTVC: NSFetchedResultsControllerDelegate {

    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>){
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet.init(integer: sectionIndex), with: .fade)
        case .delete:
            tableView.deleteSections(IndexSet.init(integer: sectionIndex), with: .fade)
        case .move:
            break
        case .update:
            break
        }

    }

    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath! as IndexPath], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath! as IndexPath], with: .fade)
        case .update:
            break
            //configureCell(tableView.cellForRowAtIndexPath(indexPath!)!, indexPath: indexPath!)
        //IMPLEMENT
        case .move:
            tableView.moveRow(at: indexPath! as IndexPath, to: newIndexPath! as IndexPath)
        }

    }
    

    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    
}



