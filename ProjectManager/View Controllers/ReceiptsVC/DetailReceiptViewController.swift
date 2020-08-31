//
//  DetailReceiptViewController.swift
//  ProjectManager
//
//  Created by Jarren Campos on 8/20/20.
//  Copyright © 2020 LambdaStudents. All rights reserved.
//

import UIKit

class DetailReceiptViewController: UIViewController {
    var receiptController = ReceiptController()
    
    @IBOutlet var receiptPreviewImageView: UIImageView!
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var placeOfPurchaseLabel: UILabel!
    @IBOutlet var itemNameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var quantityLabel: UILabel!
    @IBOutlet var descriptionTextView: UITextView!
    
    var currentIndex = 0
    
    lazy var detailReceipt = Receipt(title: "", totalCost: 0.00, category: "", image: UIImage(), date: "", description: "", quantity: "", placeOfPurchase: "")
        
    override func viewDidLoad() {
        super.viewDidLoad()
        receiptPreviewImageView.image = detailReceipt.image
        dateLabel.text = detailReceipt.date
        placeOfPurchaseLabel.text = detailReceipt.placeOfPurchase
        itemNameLabel.text = detailReceipt.title
        priceLabel.text = receiptController.floatToStringConversion(detailReceipt.totalCost, "%.2f", "$")
        quantityLabel.text = detailReceipt.quantity
        descriptionTextView.text = detailReceipt.description
    }

}
