//
//  Item.swift
//  ShoppingList
//
//  Created by Vilhelm Sturen on 2017-09-15.
//  Copyright © 2017 Vilhelm Sturen. All rights reserved.
//

import Foundation

class Item : NSObject, NSCoding {
    var name: String

    // MARK - Initialization

    init(name: String) {
        self.name = name
    }

    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
    }

    func encode(with aCoder: NSCoder)  {
        aCoder.encode(name, forKey: "name")
    }
    
}
