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
    
    @IBOutlet var tblTasks :UITableView!

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
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return taskMgr.tasksArray.count
    }
    
    override func viewWillAppear(animated: Bool) {
        
        var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context: NSManagedObjectContext = appDel.managedObjectContext!
        
        var request = NSFetchRequest(entityName: "Task")
        request.returnsObjectsAsFaults = false
        
        var results: NSArray = context.executeFetchRequest(request, error: nil)!
        
        if (results.count > 0) {
            //println("results below")
            for res in results {
                //println(res)
                taskMgr.addTask(res.valueForKey("taskName") as! String, desc: res.valueForKey("taskDesc") as! String)
            }
            // this is the bug, needs to make sure that I don't add everything I return to this view
            //println("----------------\n")
            //println(results.count)
        }
        
        
        
        
        tblTasks.reloadData()
        //println("Back to main view")
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as? UITableViewCell //reuseidentifier must match with one in storyboard
        
        var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context: NSManagedObjectContext = appDel.managedObjectContext!
        var request = NSFetchRequest(entityName: "Task")
        request.returnsObjectsAsFaults = false
        
        var results: NSArray = context.executeFetchRequest(request, error: nil)!
        
        
        
        if (cell != nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        }
        
        /*
        if (results.count > 0) {
            
            cell!.textLabel?.text = results[indexPath.row].valueForKey("taskName") as? String
            println(results[indexPath.row].valueForKey("taskName"))
            cell?.detailTextLabel!.text = results[indexPath.row].valueForKey("taskDesc") as? String
            
        } */
        
        //cell!.textLabel?.text = taskMgr.tasksArray[indexPath.row].name
        //cell!.detailTextLabel!.text = taskMgr.tasksArray[indexPath.row].desc
        
        cell!.textLabel?.text = results[indexPath.row].valueForKey("taskName") as? String
        cell!.detailTextLabel!.text = results[indexPath.row].valueForKey("taskDesc") as? String
        
        println(taskMgr.tasksArray[indexPath.row].name)
        println(results[indexPath.row].valueForKey("taskName") as! String)
        
        return cell!
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if(editingStyle == UITableViewCellEditingStyle.Delete) {
            
            let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let context:NSManagedObjectContext = appDel.managedObjectContext!
            
            var request = NSFetchRequest(entityName: "Task")
            request.returnsObjectsAsFaults = false
            
            var results: NSArray = context.executeFetchRequest(request, error: nil)!
            
            context.deleteObject(results[indexPath.row] as! NSManagedObject)
            context.save(nil)
            
            taskMgr.tasksArray.removeAtIndex(indexPath.row)
            tblTasks.reloadData()
        }
    }
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
