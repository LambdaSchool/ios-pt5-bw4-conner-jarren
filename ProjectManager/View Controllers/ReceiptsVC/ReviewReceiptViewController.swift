//
//  ReviewReceiptViewController.swift
//  ProjectManager
//
//  Created by Jarren Campos on 8/20/20.
//  Copyright © 2020 LambdaStudents. All rights reserved.
//

import UIKit

class ReviewReceiptViewController: UIViewController {
    var receiptController = ReceiptController()
    
    @IBOutlet var receiptPreviewPicture: UIImageView!
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var placeOfPurchaseLabel: UILabel!
    @IBOutlet var itemNameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var quantityLabel: UILabel!
    @IBOutlet var descriptionTextView: UITextView!
    
    var locationString: String = ""
    var dateString: String = ""
    var nameString: String = ""
    var priceFloat: Float = 0.00
    var quantityString: String = ""
    var categoryString: String = ""
    var descriptionString: String = ""
    
    var receiptImage: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBAction func addReceiptButton(_ sender: Any) {
    }
    
    func updateViews() {
        placeOfPurchaseLabel.text = locationString
        dateLabel.text = dateString
        itemNameLabel.text = nameString
        priceLabel.text = receiptController.floatToStringConversion(priceFloat, "%.2f", "$")
        quantityLabel.text = quantityString
        categoryLabel.text = categoryString
        descriptionTextView.text = descriptionString
        receiptPreviewPicture.image = receiptImage
    }

}
