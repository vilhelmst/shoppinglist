//
//  AddItemViewController.swift
//  ShoppingList
//
//  Created by Vilhelm Sturen on 2017-09-14.
//  Copyright © 2017 Vilhelm Sturen. All rights reserved.
//

import Foundation
import UIKit

class AddItemViewController: UIViewController {
    @IBOutlet weak var itemNameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.itemNameTextField.delegate = self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


// ACTIONS

extension AddItemViewController {
    @IBAction func closeAddItemPopUp(_ sender: Any) {
        self.view.removeFromSuperview()
    }

    @IBAction func addItemButtonPressed(_ sender: Any) {
        guard let itemName = itemNameTextField.text else { return }
        if !itemName.isEmpty {
            ItemList.sharedList.items.value.append(Item(name: itemName))
            self.view.removeFromSuperview()
        }
    }
}

extension AddItemViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let itemName = itemNameTextField.text else { return true }
        if !itemName.isEmpty {
            ItemList.sharedList.items.value.append(Item(name: itemName))
            self.view.removeFromSuperview()
        }
        return true
    }

}
