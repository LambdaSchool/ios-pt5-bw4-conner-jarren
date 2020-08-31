//
//  ReceiptsTableViewController.swift
//  ProjectManager
//
//  Created by Jarren Campos on 8/20/20.
//  Copyright © 2020 LambdaStudents. All rights reserved.
//

import UIKit

class ReceiptsTableViewController: UITableViewController {
    
    static var totalAmount: Float = 0.0
    static var lastReceipt: Receipt!

    let receiptController = ReceiptController()
        
    var locationString: String = ""
    var dateString: String = ""
    var nameString: String = ""
    var priceFloat: Float = 0.00
    var quantityString: String = ""
    var categoryString: String = ""
    var descriptionString: String = ""
    
    var receiptImage: UIImage!
    var currentIndex = 0
    var totalAmountHolder: Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        #warning("Reminder to remove test data")
        let testReceipt = Receipt(title: "Soil", totalCost: 25.69, category: "Outdoors", image: nil, date: receiptController.dateFormatterConfig(NSDate.now), description: "Fake text", quantity: "1", placeOfPurchase: "Home Depot", latitude: 100, longitude: 100)
        let testReceipt1 = Receipt(title: "Soil", totalCost: 50.69, category: "Outdoors", image: nil, date: receiptController.dateFormatterConfig(NSDate.now), description: "Fake text", quantity: "1", placeOfPurchase: "Home Depot", latitude: 100, longitude: 100)
        let testReceipt2 = Receipt(title: "Soil", totalCost: 100.69, category: "Outdoors", image: nil, date: receiptController.dateFormatterConfig(NSDate.now), description: "Fake text", quantity: "1", placeOfPurchase: "Home Depot", latitude: 100, longitude: 100)
        
        receiptController.addReceipt(testReceipt)
        receiptController.addReceipt(testReceipt1)
        receiptController.addReceipt(testReceipt2)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        addReceiptTotal()
        ReceiptsTableViewController.lastReceipt = receiptController.receipts.last
    }
    
    func addReceiptTotal(){
        totalAmountHolder = 0.0
        for receipts in receiptController.receipts {
            totalAmountHolder += receipts.totalCost
        }
        ReceiptsTableViewController.totalAmount = totalAmountHolder
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailReceiptVC", let destination = segue.destination as? DetailReceiptViewController {
            if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
                destination.detailReceipt = receiptController.receipts[indexPath.row]
                destination.currentIndex = indexPath.row
            }
        }
    }

    @IBAction func unwindToReceiptTableView(_ sender: UIStoryboardSegue){
        if sender.source is ReviewReceiptViewController {
            guard let senderVC = sender.source as? ReviewReceiptViewController else { return }
            locationString = senderVC.locationString
            dateString = senderVC.dateString
            nameString = senderVC.nameString
            priceFloat = senderVC.priceFloat
            quantityString = senderVC.quantityString
            categoryString = senderVC.categoryString
            descriptionString = senderVC.descriptionString
            receiptImage = senderVC.receiptImage
            
            receiptController.addReceipt(Receipt(title: locationString, totalCost: priceFloat, category: categoryString, image: receiptImage, date: dateString, description: descriptionString, quantity: quantityString, placeOfPurchase: locationString))
        } else if sender.source is DetailReceiptViewController {
            guard let senderVC = sender.source as? DetailReceiptViewController else { return }
            currentIndex = senderVC.currentIndex
            receiptController.removeReceiptAtIndex(currentIndex)
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receiptController.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "receiptCell", for: indexPath)

        cell.textLabel?.text = receiptController.floatToStringConversion(receiptController.receipts[indexPath.row].totalCost, "%.2f", "$")
        cell.detailTextLabel?.text = "\(receiptController.receipts[indexPath.row].date)"
        
        return cell
    }

}
