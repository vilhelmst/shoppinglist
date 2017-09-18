//
//  ItemList.swift
//  ShoppingList
//
//  Created by Vilhelm Sturen on 2017-09-15.
//  Copyright © 2017 Vilhelm Sturen. All rights reserved.
//

import Foundation
import RxSwift

class ItemList {

    static let sharedList = ItemList()

    let items: Variable<[Item]> = Variable([])
}
