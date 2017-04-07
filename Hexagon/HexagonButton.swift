//
//  HexagonButton.swift
//  Hexagon
//
//  Created by Gerard de Jong on 2017/04/05.
//  Copyright © 2017 Gerard de Jong. All rights reserved.
//

import UIKit
import AVFoundation

@IBDesignable

class HexagonButton: UIButton {

//MARK: Drawing
    
    @IBInspectable var borderWidth: CGFloat = 2.0
    @IBInspectable var borderInset: CGFloat = 1.0
    @IBInspectable var borderColor: UIColor = UIColor.black
    @IBInspectable var fillColor: UIColor = UIColor.gray
    @IBInspectable var fillInset: CGFloat = 8
    
    override func draw(_ rect: CGRect) {
        self.addBackgroundLayer(rect)
        self.addBorderLayer(rect)
    }
    
    func addBorderLayer(_ rect: CGRect) {
        let insetRect = CGRect(x: rect.origin.x, y: rect.origin.y, width: rect.size.width - borderInset, height: rect.size.height - borderInset)
        let hexagonLayer = self.hexagonLayer(insetRect)
        hexagonLayer.strokeColor = borderColor.cgColor
        hexagonLayer.lineWidth = borderWidth
        hexagonLayer.fillColor = UIColor.clear.cgColor
        hexagonLayer.position = CGPoint(x: borderInset/2, y: borderInset/2)
        
        self.layer.insertSublayer(hexagonLayer, below: self.layer.sublayers?.first)
    }
    
    func addBackgroundLayer(_ rect: CGRect) {
        let insetRect = CGRect(x: rect.origin.x, y: rect.origin.y, width: rect.size.width - fillInset, height: rect.size.height - fillInset)
        let hexagonLayer = self.hexagonLayer(insetRect)
        hexagonLayer.fillColor = fillColor.cgColor
        hexagonLayer.position = CGPoint(x: fillInset/2, y: fillInset/2)
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
    
// MARK: Touch event handling
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        playSoundEffect(asset: "button-press-effect")
    }
    
    var player: AVAudioPlayer?
    
    func playSoundEffect(asset: String) {
        if let asset = NSDataAsset(name:asset) {
            
            do {
                // Use NSDataAsset's data property to access the audio file stored in Sound.
                player = try AVAudioPlayer(data:asset.data, fileTypeHint:"mp3")
                // Play the above sound file.
                player?.play()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
}
