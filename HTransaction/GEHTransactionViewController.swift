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

class GEHTransactionViewController: UIViewController {

    @IBOutlet weak var GroupTextField: UITextField!
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var AmountTextField: UITextField!
    @IBOutlet weak var MemoTextField: UITextField!
    @IBOutlet weak var RepresentImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

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
        let image = ""
        
        let transaction = ["group": group, "name": name, "amount": amount,"memo": memo,"image": image, "date": todayDate]
        let baseRef = DataService.dataService.TRANSACTION_REF.childByAutoId()
        baseRef.setValue(transaction)
        
    }
}
