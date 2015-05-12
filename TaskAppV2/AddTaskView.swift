//
//  AddTaskView.swift
//  TaskAppV2
//
//  Created by Ryan Rudzitis on 2015-05-07.
//  Copyright (c) 2015 Ryan Rudzitis. All rights reserved.
//

import UIKit
import CoreData

class AddTaskView: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var txtTask :UITextField?
    @IBOutlet var txtDesc :UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    @IBAction func done(sender: UIBarButtonItem) {
        var appDel :AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context :NSManagedObjectContext = appDel.managedObjectContext!
        var alert: UIAlertController
        var newTask: NSManagedObject
        
        if (textFieldShouldEndEditing(txtTask, textFieldB: txtDesc) == true) {
            newTask = NSEntityDescription.insertNewObjectForEntityForName("Task", inManagedObjectContext: context) as! NSManagedObject
            newTask.setValue(txtTask!.text, forKey: "taskName")
            newTask.setValue(txtDesc!.text, forKey: "taskDesc")
            context.save(nil)
            
            self.dismissViewControllerAnimated(true, completion: {})
            self.view.endEditing(true) // hide keyboard
            
        } else if (textFieldShouldEndEditing(txtTask, textFieldB: txtDesc) == false) {
            alert = UIAlertController(title: "Error", message: "The textboxes cannot be blank", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: {})
        self.view.endEditing(true)
    }
    
    func textFieldShouldEndEditing(textFieldA: UITextField!, textFieldB: UITextField!) -> Bool {

        println("should end")
        if (textFieldA.text == "" || textFieldB.text == "") {
            return false
        } else {
            return true
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        println("it did end editing")
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        var nextTag = textField.tag + 1
        
        var nextResponder = textField.superview?.viewWithTag(nextTag)
        
        if ((nextResponder) != nil) {
            nextResponder!.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
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
