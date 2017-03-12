//
//  GEHTransactionViewController.swift
//  HTransaction
//
//  Created by TUAN ANH on 3/9/17.
//  Copyright © 2017 H-Transaction. All rights reserved.
//

import UIKit
import Foundation
import CoreData
import Firebase

class GEHTransactionViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var GroupTextField: UITextField!
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var AmountTextField: UITextField!
    @IBOutlet weak var MemoTextField: UITextField!
    @IBOutlet weak var RepresentImageView: UIImageView!
    var imagePicker: UIImagePickerController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func takePhoto(sender: AnyObject) {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)) {
            // show camera
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
        } else {
            // don't show camera
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
        }

        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
        imagePicker.allowsEditing = false

        presentViewController(imagePicker, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // fetch the selected image
        if picker.allowsEditing {
            RepresentImageView.image = info[UIImagePickerControllerEditedImage] as? UIImage
        } else {
            RepresentImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        }
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        //RepresentImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    @IBAction func Save(sender: AnyObject) {
        //get date
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = (calendar as NSCalendar).components([.Day,.Month,.Year], fromDate: date)
        
        let year = components.year
        let month = components.month
        let day = components.day
        
        //format month
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        let months = dateFormatter.shortMonthSymbols
        let monthSymbol = months?[month-1]
        let todayDate = "\(day) \(monthSymbol),\(year)"
        
        let group = GroupTextField.text! as NSString
        let name = NameTextField.text! as NSString
        let amount = AmountTextField.text! as NSString
        let memo = MemoTextField.text! as NSString
        
        // Get a reference to the storage service using the default Firebase App
        let storage = FIRStorage.storage()
        
        // Create a storage reference from our storage service
        let storageRef = storage.reference()
        let data: NSData = UIImageJPEGRepresentation(RepresentImageView.image!, 0.8)!
        //let filePath = "\(FIRAuth.auth()!.currentUser!.uid)/\("userPhoto")"
        let baseRef = DataService.dataService.TRANSACTION_REF.childByAutoId()
        
        let filePath = "users/\(baseRef.key)/"
        let metaData = FIRStorageMetadata()
        metaData.contentType = "image/jpg"
        storageRef.child(filePath).putData(data, metadata: metaData){(metaData,error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }else{
                //store downloadURL
                let downloadURL = metaData!.downloadURL()!.absoluteString
                //store downloadURL at database
                let image = downloadURL
                let transaction = ["group": group, "name": name, "amount": amount,"memo": memo,"image": image, "date": todayDate]
                //let baseRef = DataService.dataService.TRANSACTION_REF.childByAutoId()
                baseRef.setValue(transaction)
            }
            
        }


        
    }
}
