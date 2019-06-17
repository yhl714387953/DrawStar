//
//  ViewController.swift
//  DrawStar-Swift
//
//  Created by 嘴爷 on 2019/6/17.
//  Copyright © 2019 嘴爷. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var starView: StarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func stepChange(_ sender: UIStepper) {
        
        starView.drawStar(level:Int(sender.value), count: 7)
    }
    
}

class StarView: UIView {
    
    open var space: CGFloat = 5
    private(set) var maxStars: Int = 0//只读
    private var shapeLayers: [CAShapeLayer] = []//准备一个数组重用一下layer
    
    //    MARK: - public method
    open func drawStar(level: Int, count:Int){
        maxStars = count
        
        for i in 0...maxStars - 1 {
            
            let color = i < level ? UIColor.orange : UIColor.gray
            let height = frame.size.height
            let rect = CGRect(x: (height + space) * CGFloat(i), y: 0, width: height, height: height)
            drawSingleStar(rect: rect, color: color, index: i)
        }
    }
    
    //    MARK: - private method
    private func DEG(angle: Double) -> Double {
        return angle * Double.pi / 180.0
    }
    
    private func P_SIN(radius: Double, angle: Double) -> Double {
        return radius * sin(angle * Double.pi / 180.0)
    }
    
    private func P_COS(radius: Double, angle: Double) -> Double {
        return radius * cos(angle * Double.pi / 180.0)
    }
    
    private func drawSingleStar(rect: CGRect, color: UIColor, index: Int) {
        
        if index > shapeLayers.count - 1 { //如果缺少layer，就创建
            
            let shapeLayer = CAShapeLayer()
            shapeLayers.append(shapeLayer)
            
            let r = Double(rect.size.height / 2.0)
            let path = UIBezierPath()
            let point1 = CGPoint(x: 0, y: -r)
            let point2 = CGPoint(x: P_COS(radius: r, angle: 18), y: -P_SIN(radius: r, angle: 18));
            let point3 = CGPoint(x: P_COS(radius: r, angle: 54), y: P_SIN(radius: r, angle: 54));
            let point4 = CGPoint(x:-P_SIN(radius: r, angle: 36), y: P_COS(radius: r, angle: 36));
            let point5 = CGPoint(x:-P_COS(radius: r, angle: 18), y: -P_SIN(radius: r, angle: 18));
            path.move(to: point1)
            path.addLine(to: point3)
            path.addLine(to: point5)
            path.addLine(to: point2)
            path.addLine(to: point4)
            //        path.close()  //调不调用都可以
            
            shapeLayer.fillRule = .nonZero
            shapeLayer.frame = CGRect(x: Double(rect.origin.x) + r, y: Double(rect.origin.y) + r, width: Double(rect.size.height), height: Double(rect.size.height))
            
            shapeLayer.path = path.cgPath
            shapeLayer.fillColor = color.cgColor
            layer.addSublayer(shapeLayer)
        }else{
            let shapeLayer = shapeLayers[index]
            shapeLayer.fillColor = color.cgColor
        }
    }
    
    
}


