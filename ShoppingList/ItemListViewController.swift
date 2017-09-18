//
//  ViewController.swift
//  ShoppingList
//
//  Created by Vilhelm Sturen on 2017-09-14.
//  Copyright © 2017 Vilhelm Sturen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ItemListViewController: UIViewController {
    @IBOutlet weak var addItemButton: UIBarButtonItem!
    @IBOutlet weak var itemTableView: UITableView!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        setupCellConfiguration()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func addItemButtonTapped(_ sender: Any) {
        showAddItemPopUp()
    }

    func showAddItemPopUp() {
        let addItemPopUp = R.storyboard.addItem.addItemViewController()
        self.addChildViewController(addItemPopUp!)
        addItemPopUp?.view.frame = self.view.frame
        self.view.addSubview((addItemPopUp?.view)!)
        addItemPopUp?.didMove(toParentViewController: self)
    }
}

// RX SETUP

extension ItemListViewController {

    fileprivate func setupCellConfiguration() {

        itemTableView.rx.itemDeleted
            .subscribe(onNext: { [unowned self] indexPath in
                ItemList.sharedList.items.value.remove(at: indexPath.row)

            })
            .addDisposableTo(disposeBag)

        ItemList.sharedList.items
            .asObservable()
            .bind(to: itemTableView
                .rx
                .items(cellIdentifier: ItemCell.Identifier,
                       cellType: ItemCell.self)) {
                        row, item, cell in
                        cell.configureWith(item: item)
            }
            .addDisposableTo(disposeBag)
    }

}

