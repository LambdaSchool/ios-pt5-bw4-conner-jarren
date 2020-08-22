//
//  AddDetailsReceiptViewController.swift
//  ProjectManager
//
//  Created by Jarren Campos on 8/20/20.
//  Copyright © 2020 LambdaStudents. All rights reserved.
//

import UIKit

class AddDetailsReceiptViewController: UIViewController {
    //TODO: Need ot implement swiftUI for a graph view that updated in real time
    @IBOutlet var graphView: UIView!
    
    @IBOutlet var itemNameTextField: UITextField!
    @IBOutlet var priceTextField: UITextField!
    @IBOutlet var quantityTextField: UITextField!
    @IBOutlet var categoryTextField: UITextField!
    @IBOutlet var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func reviewButtonPressed(_ sender: Any) {
        
    }
}

extension AddDetailsReceiptViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
