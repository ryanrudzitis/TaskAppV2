//
//  MainTaskView.swift
//  TaskAppV2
//
//  Created by Ryan Rudzitis on 2015-05-07.
//  Copyright (c) 2015 Ryan Rudzitis. All rights reserved.
//

import UIKit
import CoreData

class MainTaskView: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet var tblTasks: UITableView!

    
    @IBAction func addTask(sender: AnyObject) {
        performSegueWithIdentifier("addTaskSegue", sender: self)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let longPress = UILongPressGestureRecognizer()
        
        /*Add long press gesture*/
        longPress.addTarget(self, action: "longPressedView:")
        tblTasks.addGestureRecognizer(longPress)
        tblTasks.userInteractionEnabled = true
        
        //self.clearsSelectionOnViewWillAppear = false

        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        self.tableView.registerNib(UINib(nibName: "MyCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    override func viewDidDisappear(animated: Bool) {
        self.navigationController?.editing = false
    }
    
    func longPressedView(gestureRecognizer: UIGestureRecognizer){
        
        /*Get cell info from where user tapped*/
        if (gestureRecognizer.state == .Began) {
            var tapLocation: CGPoint = gestureRecognizer.locationInView(self.tableView)
            
            var tappedIndexPath: NSIndexPath? = self.tableView.indexPathForRowAtPoint(tapLocation)
            if (tappedIndexPath != nil) {
                var tappedCell: UITableViewCell? = self.tableView.cellForRowAtIndexPath(tappedIndexPath!)
            }
        
            /*Long press alert*/
            let tapAlert = UIAlertController(title: "Long Pressed", message: "You just long pressed the long press view", preferredStyle: UIAlertControllerStyle.Alert)
            tapAlert.addAction(UIAlertAction(title: "OK", style: .Destructive, handler: nil))
            self.presentViewController(tapAlert, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let results = getCoreDataArray("Task")
        println(results.count)
        return results.count
    }
    
    override func viewWillAppear(animated: Bool) {
        tblTasks.reloadData()
        /*Hide tool bar upon loading*/
        self.navigationController?.setToolbarHidden(true, animated: animated)
    }
    
    func addBlurEffect() {
        var bounds = self.navigationController?.navigationBar.bounds as CGRect!
        var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
        visualEffectView.frame = bounds
        visualEffectView.autoresizingMask = .FlexibleHeight | .FlexibleWidth
        self.navigationController?.navigationBar.addSubview(visualEffectView)
        self.navigationController?.navigationBar.translucent = true
    }
    
    @IBAction func deleteAll(sender: UIBarButtonItem) {
        var appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context: NSManagedObjectContext = appDel.managedObjectContext!
        
        /*Set the option view*/
        let optionMenu = UIAlertController(title: nil, message: "Are you sure you want to delete all tasks?", preferredStyle: .ActionSheet)
        
        /*Set the actions for pressing delete*/
        let deleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: {(alert: UIAlertAction!) -> Void in
            var request = NSFetchRequest(entityName: "Task")
            var results: NSArray = context.executeFetchRequest(request, error: nil)!
            
            for item: AnyObject in results {
                context.deleteObject(item as! NSManagedObject)
            }
            
            context.save(nil)
            self.tblTasks.reloadData()
            self.navigationController?.editing = false
            })
        
        /*Set the cancel action*/
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default, handler: {(alert: UIAlertAction!) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
            self.navigationController?.editing = false
            })
        
        /*Finally show the menu*/
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(cancelAction)
        
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //var cell = tableView.dequeueReusableCellWithIdentifier("cell") as? MyCell
        let cell = tableView.dequeueReusableCellWithIdentifier("cell",
            forIndexPath:indexPath) as? MyCell
        
        if cell == nil {
            println("it is nill")
        }

        var results = getCoreDataArray("Task")
        
        cell!.textField.text = results[indexPath.row].valueForKey("taskName") as? String
        cell!.textField.delegate = self
        return cell!
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }


    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        /*What happens if user presses delete on cell*/
        if (editingStyle == .Delete) {
            let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let context:NSManagedObjectContext = appDel.managedObjectContext!
            var request = NSFetchRequest(entityName: "Task")
            var results: NSArray = context.executeFetchRequest(request, error: nil)!
            
            context.deleteObject(results[indexPath.row] as! NSManagedObject)
            context.save(nil)
            self.navigationController?.editing = false
            
            tblTasks.reloadData()
        }
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        /*Hide/show toolbar based on edit button status*/
        if (editing) {
            self.navigationController?.setToolbarHidden(false, animated: animated)
        } else {
            self.navigationController?.setToolbarHidden(true, animated: animated)
        }
    }
    
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return false
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.endEditing(true)
        self.navigationController?.editing = false
        return false
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        // some cell's text field has finished editing; which cell?
        var v : UIView = textField
        do { v = v.superview! } while !(v is UITableViewCell)

        let cell = v as! MyCell
        // update data model to match
        
        var appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var context: NSManagedObjectContext = appDel.managedObjectContext!
        
        var request = NSFetchRequest(entityName: "Task")
        request.predicate = NSPredicate(format: "taskName = %@", "ok")
        
        if let fetchResults = appDel.managedObjectContext!.executeFetchRequest(request, error: nil) as? [NSManagedObject] {
            if fetchResults.count != 0{
                var managedObject = fetchResults[0]
                managedObject.setValue(textField.text, forKey: "taskName")
                
                context.save(nil)
                tblTasks.reloadData()
            }
        }
        
        
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