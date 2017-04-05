//
//  HexagonButton.swift
//  Hexagon
//
//  Created by Gerard de Jong on 2017/04/05.
//  Copyright © 2017 Gerard de Jong. All rights reserved.
//

import UIKit

@IBDesignable

class HexagonButton: UIButton {
    
    @IBInspectable var borderColor: UIColor = UIColor.black
    @IBInspectable var fillColor: UIColor = UIColor.gray
    @IBInspectable var hexagonInset: CGFloat = 10
    
    override func draw(_ rect: CGRect) {
        //let insettedRect = CGRect(x: rect.origin.x + hexagonInset, y: rect.origin.y + hexagonInset, width: rect.size.width - hexagonInset, height: rect.size.height - hexagonInset);
        
        self.addBackgroundLayer(rect)
        //self.addBorderLayer(rect)
    }
    
    func addBorderLayer(_ rect: CGRect) {
        let hexagonLayer = self.hexagonLayer(rect)
        
        hexagonLayer.borderColor = borderColor.cgColor
        hexagonLayer.fillColor = UIColor.clear.cgColor
        hexagonLayer.borderWidth = 2
        
        self.layer.insertSublayer(hexagonLayer, below: self.layer.sublayers?.first)
    }
    
    func addBackgroundLayer(_ rect: CGRect) {
        let hexagonLayer = self.hexagonLayer(rect)
        hexagonLayer.fillColor = fillColor.cgColor
        self.layer.insertSublayer(hexagonLayer, below: self.layer.sublayers?.first)
    }
    
    func hexagonLayer(_ rect: CGRect) -> CAShapeLayer {
        let hexagonLayer = CAShapeLayer()
        hexagonLayer.path = self.hexagonPath(rect)
        return hexagonLayer
    }
    
    func hexagonPath(_ rect: CGRect) -> CGPath {
        let path = CGMutablePath()
        let inset = rect.width / 4
        
        path.move(to: CGPoint(x: rect.origin.x, y: rect.height/2))
        path.addLine(to: CGPoint(x: inset, y: 0))
        path.addLine(to: CGPoint(x: rect.width - inset, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height/2))
        path.addLine(to: CGPoint(x: rect.width - inset, y: rect.height))
        path.addLine(to: CGPoint(x: inset, y: rect.height))
        path.closeSubpath()
        
        return path
    }

}
