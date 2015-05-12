//
//  MainTaskView.swift
//  TaskAppV2
//
//  Created by Ryan Rudzitis on 2015-05-07.
//  Copyright (c) 2015 Ryan Rudzitis. All rights reserved.
//

import UIKit
import CoreData

class MainTaskView: UITableViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tblTasks: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var results = getCoreDataArray("Task")
        
        return results.count
    }
    
    override func viewWillAppear(animated: Bool) {
        tblTasks.reloadData()
    }
    
    @IBAction func deleteAll(sender: UIBarButtonItem) {
        var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context: NSManagedObjectContext = appDel.managedObjectContext!
        
        let optionMenu = UIAlertController(title: nil, message: "Are you sure you want to delete all?", preferredStyle: .ActionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: {(alert: UIAlertAction!) -> Void in
            var request = NSFetchRequest(entityName: "Task")
            var results: NSArray = context.executeFetchRequest(request, error: nil)!
            
            for item: AnyObject in results {
                context.deleteObject(item as! NSManagedObject)
            }
            
            context.save(nil)
            self.tblTasks.reloadData()
            })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default, handler: {(alert: UIAlertAction!) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
            })
        
        
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(cancelAction)
        
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as? UITableViewCell //reuseidentifier must match with one in storyboard
        
        var results = getCoreDataArray("Task")
        
        if (cell != nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        }
        
        cell!.textLabel?.text = results[indexPath.row].valueForKey("taskName") as? String
        cell!.detailTextLabel!.text = results[indexPath.row].valueForKey("taskDesc") as? String
        
        
        return cell!
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }


    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let context:NSManagedObjectContext = appDel.managedObjectContext!
            var request = NSFetchRequest(entityName: "Task")
            var results: NSArray = context.executeFetchRequest(request, error: nil)!
            
            context.deleteObject(results[indexPath.row] as! NSManagedObject)
            context.save(nil)
            
            tblTasks.reloadData()
        }
    }
    
    //override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //return 1
    //}
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        
    }
    */

    
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return false
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}