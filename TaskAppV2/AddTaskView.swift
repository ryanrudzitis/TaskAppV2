//
//  AddTaskView.swift
//  TaskAppV2
//
//  Created by Ryan Rudzitis on 2015-05-07.
//  Copyright (c) 2015 Ryan Rudzitis. All rights reserved.
//

import UIKit
import CoreData

class AddTaskView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    @IBOutlet var txtTask :UITextField!
    @IBOutlet var txtDesc :UITextField!
    
    
    @IBAction func Done(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: {})
        self.view.endEditing(true) // hide keyboard
        
        var appDel :AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context :NSManagedObjectContext = appDel.managedObjectContext!
        
        var newTask = NSEntityDescription.insertNewObjectForEntityForName("Task", inManagedObjectContext: context) as! NSManagedObject
        
        newTask.setValue(txtTask.text, forKey: "taskName")
        newTask.setValue(txtDesc.text, forKey: "taskDesc")
        context.save(nil)
        
        println(newTask)
        println("object saved")
        
        txtTask.text = ""
        txtDesc.text = ""
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
