//
//  ItemCell.swift
//  ShoppingList
//
//  Created by Vilhelm Sturen on 2017-09-15.
//  Copyright © 2017 Vilhelm Sturen. All rights reserved.
//
import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var itemNameLabel: UILabel!
    static let Identifier = "ItemCell"

    func configureWith(item: Item) {
        itemNameLabel.text = item.name
    }
}
