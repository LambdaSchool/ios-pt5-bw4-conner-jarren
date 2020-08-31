//
//  AddDetailsReceiptViewController.swift
//  ProjectManager
//
//  Created by Jarren Campos on 8/20/20.
//  Copyright © 2020 LambdaStudents. All rights reserved.
//

import UIKit

class AddDetailsReceiptViewController: UIViewController {
    var receiptController = ReceiptController()
    
    @IBOutlet var graphView: UIView!
    
    @IBOutlet var itemNameTextField: UITextField!
    @IBOutlet var priceTextField: UITextField!
    @IBOutlet var quantityTextField: UITextField!
    @IBOutlet var categoryTextField: UITextField!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var priceAmount: UILabel!
    
    var locationString: String = ""
    var dateString: String = ""
    var imageViewPreview: UIImage!
    var colorChooser: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionTextView.text = ""
        graphView.backgroundColor = UIColor.clear
        createGraph()
    }
    
    func createGraph() {
        let shapeLayer = CAShapeLayer()
        
        let center = CGPoint(x: 100, y: 100)
        let circularPath = UIBezierPath(arcCenter: center, radius: 75, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        shapeLayer.strokeEnd = 0
        if colorChooser == false{
            shapeLayer.strokeColor = UIColor.systemBlue.cgColor
        } else {
            shapeLayer.strokeColor = UIColor.systemRed.cgColor
        }
        colorChooser.toggle()
        shapeLayer.lineWidth = 30
        shapeLayer.lineCap =  CAShapeLayerLineCap.round
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        
        graphView.layer.addSublayer(shapeLayer)
        
        let animcolor = CABasicAnimation(keyPath: "strokeEnd")
        animcolor.fromValue = UIColor.green.cgColor
        animcolor.toValue = UIColor.orange.cgColor
        animcolor.duration = 1.0
        animcolor.isRemovedOnCompletion = false
        animcolor.fillMode = CAMediaTimingFillMode.forwards
        
        shapeLayer.add(animcolor, forKey: "strokeEnd")
        
    }
    
    @IBAction func reviewButtonPressed(_ sender: Any) {
        if itemNameTextField.text == "" {
            Alert.showIncompleteFormAlert(on: self)
        } else if priceTextField.text == ""{
            Alert.showIncompleteFormAlert(on: self)
        } else if quantityTextField.text == ""{
            Alert.showIncompleteFormAlert(on: self)
        } else if categoryTextField.text == ""{
            Alert.showIncompleteFormAlert(on: self)
        } else if descriptionTextView.text == ""{
            Alert.showIncompleteFormAlert(on: self)
        }
        else{
            performSegue(withIdentifier: "toReviewVC", sender: UIButton.self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toReviewVC", let destination = segue.destination as? ReviewReceiptViewController {
            destination.locationString = locationString
            destination.dateString = dateString
            destination.receiptImage = imageViewPreview
            
            guard let name = itemNameTextField.text else {return}
            destination.nameString = name
            
            let price = priceTextField.floatValue
            destination.priceFloat = price
            
            guard let quantity = quantityTextField.text else {return}
            destination.quantityString = quantity
            
            guard let category = categoryTextField.text else {return}
            destination.categoryString = category
            
            guard let description = descriptionTextView.text else {return}
            destination.descriptionString = description
            
        }
    }
    @IBAction func updatePriceLabel(_ sender: Any) {
        let price = priceTextField.floatValue
        priceAmount.text = receiptController.floatToStringConversion(price, "%.2f", "$")
        createGraph()
    }
}

extension UITextField {
    var floatValue : Float {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        let nsNumber = numberFormatter.number(from: text!)
        return nsNumber == nil ? 0.0 : nsNumber!.floatValue
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
