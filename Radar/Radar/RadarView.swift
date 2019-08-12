//
//  RadarView.swift
//  Radar
//
//  Created by Hossam on 8/11/19.
//  Copyright © 2019 Hossam. All rights reserved.
//

import UIKit
@IBDesignable

class RadarView : UIView {
    
    
    
    
    
    override func layoutSubviews() {
        drawMyRadar()
    }
    lazy var points : [CGPoint] = [.init(x: 170, y: 430) , .init(x: 110, y: 390) , .init(x: 190, y: 348)  , .init(x: 110, y: 480 ) , .init(x: 245, y: 480) , .init(x: 230, y: 450) , .init(x: 304, y: 140) , .init(x: 270, y: 300) , .init(x: 145, y: 275) ]
  
    
    
    func drawMyRadar(){
        
        let width = min(bounds.width, bounds.height)
        let baseLayer = CAShapeLayer()
        let basePath = UIBezierPath()
        let radarLayer = CAShapeLayer()
        let radarPath = UIBezierPath()
        
        basePath.addArc(withCenter: center, radius: width/3, startAngle: 2*CGFloat.pi , endAngle: 2*CGFloat.pi - 0.01, clockwise: true)
        baseLayer.path = basePath.cgPath
        baseLayer.frame = bounds
        baseLayer.fillColor = UIColor.darkGray.cgColor
        baseLayer.opacity = 0.8
        
       
        
        
        radarPath.addArc(withCenter: center, radius: width/3, startAngle: 2*CGFloat.pi + 0.3, endAngle: CGFloat.pi/2.4, clockwise: true)
        radarPath.addLine(to: center)

//        radarPath.apply(.init(translationX: -self.center.x, y: -self.center.y))
//        radarPath.apply(.init(rotationAngle: angel))
//        radarPath.apply(.init(translationX: self.center.x, y: self.center.y))
        radarLayer.path = radarPath.cgPath
        radarLayer.fillColor = UIColor.white.cgColor
        radarLayer.frame = radarLayer.bounds
        radarLayer.opacity = 0.4
        
        let pointsInRegionLayer = CAShapeLayer()
        let pointsOutFromRegionLayer = CAShapeLayer()
        let pointsInRegionPath = UIBezierPath()
        let pointsOutFromRegionPath = UIBezierPath()
        
        for point in points {
            if radarPath.contains(point) {
                let path = UIBezierPath(ovalIn: .init(x: point.x, y: point.y, width: 18, height: 18))
                pointsInRegionPath.append(path)
                print(point)
                
            }
            else {
                 let path = UIBezierPath(ovalIn: .init(x: point.x, y: point.y, width: 18, height: 18))
                pointsOutFromRegionPath.append(path)
            }
        }
        
        pointsInRegionLayer.path = pointsInRegionPath.cgPath
        pointsInRegionLayer.frame = bounds
        pointsInRegionLayer.fillColor = UIColor.white.cgColor
        pointsInRegionLayer.strokeColor = UIColor.blue.cgColor
        pointsInRegionLayer.lineWidth = 4
        pointsInRegionLayer.opacity = 0.7
        
        pointsOutFromRegionLayer.path = pointsOutFromRegionPath.cgPath
        pointsOutFromRegionLayer.frame = bounds
        pointsOutFromRegionLayer.fillColor = nil
        pointsOutFromRegionLayer.strokeColor = UIColor.white.cgColor
        pointsOutFromRegionLayer.lineWidth = 3
        pointsOutFromRegionLayer.opacity = 0.4
        
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = basePath.cgPath
        maskLayer.frame = bounds
        pointsOutFromRegionLayer.mask = maskLayer
        
        
        baseLayer.addSublayer(pointsInRegionLayer)
        baseLayer.addSublayer(pointsOutFromRegionLayer)
        baseLayer.addSublayer(radarLayer)
        if let firstLayer = self.layer.sublayers?.first {
            self.layer.replaceSublayer(firstLayer, with: baseLayer)
        }else {
         self.layer.addSublayer(baseLayer)
        }
        
    }
    
    
    
    
}

