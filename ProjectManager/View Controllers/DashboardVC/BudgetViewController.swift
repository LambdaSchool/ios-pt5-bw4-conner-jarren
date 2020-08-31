//
//  BudgetViewController.swift
//  ProjectManager
//
//  Created by Jarren Campos on 8/29/20.
//  Copyright © 2020 LambdaStudents. All rights reserved.
//

import UIKit

class BudgetViewController: UIViewController {
    
    var receiptController = ReceiptController()
    static var budgetTotalPercentage: Float = 0.0
    static var budgetTotalAmount: Float = 0.0
    
    @IBOutlet var sliderOutlet: UISlider!
    @IBOutlet var budgetTotal: UILabel!
    @IBOutlet var widgetView: UIView!
    @IBOutlet var percentageOutlet: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if BudgetViewController.budgetTotalAmount == 0.0{
            budgetTotal.text = receiptController.floatToStringConversion(sliderOutlet.value, "%.2f", "$")
        } else {
            budgetTotal.text = receiptController.floatToStringConversion(BudgetViewController.budgetTotalAmount, "%.2f", "$")
        }
        createGraph(UIColor.white.cgColor, 2 * CGFloat.pi, 1.0, 20)
        createGraph(UIColor.systemBlue.cgColor, percentToRadians(CGFloat(BudgetViewController.budgetTotalPercentage)), 1.0, 20)
        if BudgetViewController.budgetTotalPercentage == 0.0{
            percentageOutlet.text = "0%"
        } else {
            percentageOutlet.text = receiptController.floatToStringConversion(BudgetViewController.budgetTotalPercentage, "rounded", "%")
        }
        sliderOutlet.value = BudgetViewController.budgetTotalAmount
    }
    
    func percentToRadians(_ percent: CGFloat) -> CGFloat {
        var total: CGFloat = percent * 0.062831853071796
        if total > 6.2831853071796 {
            total = 6.2831853071796
        }
        return total
    }
    
    func run(after seconds: Int, completion: @escaping () -> Void) {
        let deadline = DispatchTime.now() + .seconds(seconds)
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            completion()
        }
    }
    
    func calcPercentage(_ x: Float, _ y: Float) -> Float {
        return (x / y) * 100.0
    }
    
    func createGraphReset() {
        run(after: 2) {
            self.createGraph(UIColor.white.cgColor, 2 * CGFloat.pi, 1.0, 20)
            self.createGraph(UIColor.systemBlue.cgColor, self.percentToRadians(CGFloat(BudgetViewController.budgetTotalPercentage)), 1.0, 20)
        }
        createGraph(widgetView.backgroundColor!.cgColor, 2 * CGFloat.pi, 1.0, 50)
    }
    
    func createGraph(_ color: CGColor, _ endAngle: CGFloat, _ animated: CFTimeInterval, _ lineWidth: CGFloat) {
        let shapeLayer = CAShapeLayer()
        
        let center = CGPoint(x: 210, y: 450)
        let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: 0, endAngle: endAngle, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        shapeLayer.strokeEnd = 0
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineCap =  CAShapeLayerLineCap.round
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        
        view.layer.addSublayer(shapeLayer)
        
        let animcolor = CABasicAnimation(keyPath: "strokeEnd")
        animcolor.fromValue = UIColor.green.cgColor
        animcolor.toValue = UIColor.orange.cgColor
        animcolor.duration = animated
        animcolor.isRemovedOnCompletion = false
        animcolor.fillMode = CAMediaTimingFillMode.forwards
        
        shapeLayer.add(animcolor, forKey: "strokeEnd")
        
    }
    
    @IBAction func sliderChanged(_ sender: Any) {
        BudgetViewController.budgetTotalAmount = sliderOutlet.value
        BudgetViewController.budgetTotalPercentage = calcPercentage(BudgetViewController.budgetTotalAmount, ReceiptsTableViewController.totalAmount)
        budgetTotal.text = receiptController.floatToStringConversion(sliderOutlet.value, "%.2f", "$")
        run(after: 1) {
            self.createGraphReset()
        }
        run(after: 2) {
            self.percentageOutlet.text = self.receiptController.floatToStringConversion(BudgetViewController.self.budgetTotalPercentage, "rounded", "%")
        }
    }
    
}
