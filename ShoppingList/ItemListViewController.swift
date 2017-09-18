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
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var addItemButton: UIBarButtonItem!
    @IBOutlet weak var itemTableView: UITableView!
    let disposeBag = DisposeBag()
    var shownItems: Variable<[Item]> = Variable([])


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        searchBar.delegate = self



        setupCellConfiguration()
        setupSearchBarConfiguration()
    }

    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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

        self.shownItems
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

    fileprivate func setupSearchBarConfiguration() {

        ItemList.sharedList.items
            .asObservable()
            .subscribe(onNext: { value in
                self.shownItems.value = ItemList.sharedList.items.value
            })
            .addDisposableTo(disposeBag)

        searchBar
            .rx.text // Observable property thanks to RxCocoa
            .orEmpty // Make it non-optional
            .debounce(0.5, scheduler: MainScheduler.instance) // Wait 0.5 for changes.
            .distinctUntilChanged() // If they didn't occur, check if the new value is the same as old.
            .subscribe(onNext: { [unowned self] query in // Here we subscribe to every new value
                self.shownItems.value =  ItemList.sharedList.items.value.filter { $0.name.hasPrefix(query) }
            })
            .addDisposableTo(disposeBag)

    }

}

extension ItemListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked( _ searchBar: UISearchBar)
    {
        view.endEditing(true)
    }
}

