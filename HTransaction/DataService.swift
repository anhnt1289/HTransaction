//
//  DataService.swift
//  HTransaction
//
//  Created by bipvietnam on 3/8/17.
//  Copyright © 2017 H-Transaction. All rights reserved.
//

import Foundation
import Firebase
class DataService {
    static let dataService = DataService()
    
    private var _BASE_REF = FIRDatabase.database().referenceFromURL(BASE_URL)
    private var _USER_REF = FIRDatabase.database().referenceFromURL("\(BASE_URL)/users")
    private var _TRANSACTION_REF = FIRDatabase.database().referenceFromURL("\(BASE_URL)/transactions")
    
    var BASE_REF: FIRDatabaseReference {
        return _BASE_REF
    }
    
    var USER_REF: FIRDatabaseReference {
        return _USER_REF
    }
    
    var CURRENT_USER_REF: FIRDatabaseReference {
        let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
        
        let currentUser = FIRDatabase.database().referenceFromURL("\(BASE_REF)").child("users").child(userID)
        
        return currentUser
    }
    
    var TRANSACTION_REF: FIRDatabaseReference {
        return _TRANSACTION_REF
    }
    
    func createNewAccount(uid: String, user: Dictionary<String, String>) {
        
        // A User is born.
        
        USER_REF.child(uid).setValue(user)
    }
    
    func createNewJoke(joke: Dictionary<String, AnyObject>) {
        
        // Save the Joke
        // JOKE_REF is the parent of the new Joke: "jokes".
        // childByAutoId() saves the joke and gives it its own ID.
        
        let firebaseNewJoke = TRANSACTION_REF.childByAutoId()
        
        // setValue() saves to Firebase.
        
        firebaseNewJoke.setValue(joke)
    }
}