//
//  EventsViewController.swift
//  InRoZe
//
//  Created by Erick Olibo on 22/09/2017.
//  Copyright © 2017 Erick Olibo. All rights reserved.
//

import UIKit
import CoreData

class EventsViewController: FetchedResultsTableViewController {
    
    // properties
    let eventCell = "Event Cell"

    
    
    // All this are from AutoLayout in the main.Storyboard
    let marginWidth: CGFloat = 18 * 2
    let aboveCoverMargin: CGFloat = 60
    let belowCoverMargin: CGFloat = 10
    let coverRatio = CGFloat(16) / 9
    let phoneSizeWidth = UIScreen.main.bounds.width
    let djCellMargin: CGFloat = 70
    let belowDjCellMargin: CGFloat = 10
    
    var cellHeightDefault: CGFloat = 0
    var cellHeightDeejays: CGFloat = 0
    

    // Core dat Model container and context
    var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    let mainContext = AppDelegate.viewContext
    
    lazy var fetchResultsController: NSFetchedResultsController = { () -> NSFetchedResultsController<Event> in
        
        // Initilaze Fetch Request
        let request: NSFetchRequest<Event> = Event.fetchRequest()
        let nowTime = NSDate()
        
        // Add sor Descriptors and Predicate
        request.sortDescriptors = [NSSortDescriptor(key: "startTime", ascending: true, selector: nil)]
        request.predicate = NSPredicate(format: "endTime > %@ AND imageURL != nil AND name != nil AND text != nil", nowTime)
        request.fetchBatchSize = 20
        
        // Initialze Fetched Results Controller
        

        
        let fetchedRC = NSFetchedResultsController(fetchRequest: request, managedObjectContext: self.mainContext, sectionNameKeyPath: nil, cacheName: nil)
        
        // Configure Fetch Results Controller
        fetchedRC.delegate = self
        
        return fetchedRC
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // the NIB to be loaded
        let nibNameDefault = UINib(nibName: "EventTVDefaultCell", bundle: nil)
        tableView.register(nibNameDefault, forCellReuseIdentifier: "Event Default Cell")
        let nibNameDeejay = UINib(nibName: "EventTVDeejayCell", bundle: nil)
        tableView.register(nibNameDeejay, forCellReuseIdentifier: "Event Deejay Cell")
        
        // Estimated rowHeight
        let coverHeight = (phoneSizeWidth - marginWidth) / coverRatio
        cellHeightDefault = aboveCoverMargin + coverHeight + belowCoverMargin
        cellHeightDeejays = aboveCoverMargin + coverHeight + djCellMargin + belowDjCellMargin
        print("DJ: \(cellHeightDeejays) - Default: \(cellHeightDefault)")
        
//        tableView.estimatedRowHeight = cellHeightDefault
//        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.tintColor = UIColor.changeHexStringToColor(ColorInHexFor.logoRed)
        print("EventsViewController")
        updateUI()

        RequestHandler().fetchEventIDsFromServer()
        
    }
    

    
    private func updateUI() {
        
        // Execute the FetchRequest
        do {
            try self.fetchResultsController.performFetch()
            self.tableView.reloadData()
            
        } catch {
            print("Error in performFetch - EventVC - updateUI()")

        }
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
