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

        println("ok")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet var txtTask :UITextField!
    @IBOutlet var txtDesc :UITextField!
    
    @IBAction func done(sender: UIBarButtonItem) {
        var appDel :AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context :NSManagedObjectContext = appDel.managedObjectContext!
        
        if (textFieldShouldEndEditing(txtTask, textFieldB: txtDesc) == true) {
            var newTask = NSEntityDescription.insertNewObjectForEntityForName("Task", inManagedObjectContext: context) as! NSManagedObject
            newTask.setValue(txtTask.text, forKey: "taskName")
            newTask.setValue(txtDesc.text, forKey: "taskDesc")
            context.save(nil)
            
            self.dismissViewControllerAnimated(true, completion: {})
            self.view.endEditing(true) // hide keyboard
            
            
        } else if (textFieldShouldEndEditing(txtTask, textFieldB: txtDesc) == false){
            println("bad")
        }
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: {})
        self.view.endEditing(true)
    }
    
    func textFieldShouldEndEditing(textFieldA: UITextField!, textFieldB: UITextField!) -> Bool {
        if (textFieldA.text == "" || textFieldB.text == "") {
            return false
        } else {
            return true
        }
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
