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
    
    var cancelButtonPressed = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 51/255, green: 153/255, blue: 255/255, alpha: 1.0)
        var nextResponder = txtTask?.viewWithTag(1)
        
        if ((nextResponder) != nil) {
            nextResponder?.becomeFirstResponder()
        }
        
        cancelButtonPressed = false
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    @IBAction func done(AnyObject) {
        var appDel :AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context :NSManagedObjectContext = appDel.managedObjectContext!
        var alert: UIAlertController
        var newTask: NSManagedObject
        
        if (txtTask!.text != "") {
            newTask = NSEntityDescription.insertNewObjectForEntityForName("Task", inManagedObjectContext: context) as! NSManagedObject
            newTask.setValue(txtTask!.text, forKey: "taskName")
            //newTask.setValue(txtDesc!.text, forKey: "taskDesc")
            context.save(nil)
            
            self.dismissViewControllerAnimated(true, completion: {})
            self.view.endEditing(true) // hide keyboard
            
        } else {
            textFieldShouldEndEditing(txtTask!)
            //textFieldShouldEndEditing(txtDesc!)
        }
    }

    @IBAction func cancel(sender: UIBarButtonItem) {
        cancelButtonPressed = true
        self.dismissViewControllerAnimated(true, completion: {})
        self.view.endEditing(true)
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        if (textField.text == "" && cancelButtonPressed == false) {
            let alert: UIAlertController = UIAlertController(title: "Error", message: "Contents of textbox cannot be blank", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            //self.presentViewController(alert, animated: true, completion: nil)
            
            if self.presentedViewController == nil {
                self.presentViewController(alert, animated: true, completion: nil)
            } else {
                println("already presenting")
            }
            return false
        } else {
            return true
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if (textFieldShouldEndEditing(textField) == false) {
            //println("returned false")
        } else {
            //println("returned true")
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        var nextTag = textField.tag + 1
        var nextResponder = textField.superview?.viewWithTag(nextTag)
        
        if ((nextResponder) != nil) {
            textField.resignFirstResponder()
            nextResponder!.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            done(self)
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
