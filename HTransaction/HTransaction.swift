//
//  HTransaction.swift
//  HTransaction
//
//  Created by TUAN ANH on 3/12/17.
//  Copyright © 2017 H-Transaction. All rights reserved.
//

import Foundation
import Firebase
class HTransaction {
    private var _hTransactionRef: FIRDatabaseReference!
    
    private var _hTransactionName: String!
    private var _hTransactionMemo: String!
    private var _hTransactionAmount: Int!
    private var _hTransactionGroup: String!
    private var _hTransactionImage: String!
    private var _hTransactionDate: String!
    private var _hTransactionUser: String!
    private var _hTransactionKey: String!
    
    var hTransactionName: String {
        return _hTransactionName
    }
    
    var hTransactionMemo: String {
        return _hTransactionMemo
    }
    
    var hTransactionAmount: Int {
        let number = _hTransactionAmount != nil ? _hTransactionAmount! : 0
        return number
    }
    
    var hTransactionGroup: String {
        return _hTransactionGroup
    }
    
    var hTransactionImage: String {
        return _hTransactionImage
    }
    
    var hTransactionDate: String {
        return _hTransactionDate
    }
    
    var hTransactionUser: String {
        return _hTransactionUser
    }
    // Initialize the new Joke
    
    init(key: String, dictionary: Dictionary<String, AnyObject>) {
        self._hTransactionKey = key
        // Within the Joke, or Key, the following properties are children
        if let name = dictionary["name"] as? String {
            self._hTransactionName = name
        }
        if let memo = dictionary["memo"] as? String {
            self._hTransactionMemo = memo
        }
        
        if let amount = dictionary["amount"] as? Int  {
            self._hTransactionAmount = amount
        }
        
        if let group = dictionary["group"] as? String {
            self._hTransactionGroup = group
        }
        
        if let image = dictionary["image"] as? String {
            self._hTransactionImage = image
        }
        
        if let date = dictionary["date"] as? String {
            self._hTransactionDate = date
        }
        
        if let user = dictionary["user"] as? String {
            self._hTransactionUser = user
        }
        
        // The above properties are assigned to their key.
        self._hTransactionRef = DataService.dataService.TRANSACTION_REF.child(self._hTransactionKey)

    }
}