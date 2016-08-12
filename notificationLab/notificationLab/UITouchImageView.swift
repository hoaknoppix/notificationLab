//
//  UIDrawingImageView.swift
//  CICADA
//
//  Created by hoaqt on 8/11/16.
//  Copyright © 2016 Dang Quoc Huy. All rights reserved.
//

import UIKit

protocol UIDrawingImageViewDelegate {
    func setUndoButtonEnabled(enabled: Bool)
    func setRedoButtonEnabled(enabled: Bool)

}

class UIDrawingImageView: UIImageView {
    
    var delegate: UIDrawingImageViewDelegate?
    
    var lastPoint = CGPoint.zero

    var originalImage = UIImage()
    
    var editedImage = UIImage()
    
    var redoImages = [UIImage]()
    
    var undoImages = [UIImage]()
    
    var brushColor: CGColor = UIColor.blackColor().CGColor
    
    var brushWidth: CGFloat = 50.0
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        undoImages.append(image!)
        redoImages = []
        delegate?.setRedoButtonEnabled(redoImages.count > 0)
        delegate?.setUndoButtonEnabled(undoImages.count > 0)
        let touch = touches.first!
        lastPoint = touch.locationInView(self)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
            if let touch = touches.first {
                let currentPoint = touch.locationInView(self)
                drawLine(lastPoint, toPoint: currentPoint)
                lastPoint = currentPoint
            }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        editedImage = image!
    }
    
    func drawLine(fromPoint: CGPoint, toPoint: CGPoint) {
        
        UIGraphicsBeginImageContext(frame.size)
        let context = UIGraphicsGetCurrentContext()
        image?.drawInRect(CGRect(x: 0, y: 0, width: frame.width, height: self.frame.height))
        CGContextSetLineCap(context, CGLineCap.Round)
        CGContextSetLineWidth(context, brushWidth)
        CGContextSetStrokeColorWithColor(context, brushColor)
        CGContextMoveToPoint(context, fromPoint.x, fromPoint.y)
        CGContextAddLineToPoint(context, toPoint.x, toPoint.y)
        CGContextStrokePath(context)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        image = newImage
    }

    
    func undo() {
        guard undoImages.count > 0 else {
            return
        }
        redoImages.append(image!)
        image = undoImages.last
        undoImages.removeLast()
        delegate?.setRedoButtonEnabled(redoImages.count > 0)
        delegate?.setUndoButtonEnabled(undoImages.count > 0)
        
    }
    
    func redo() {
        guard redoImages.count > 0 else {
            return
        }
        undoImages.append(image!)
        image = redoImages.last
        redoImages.removeLast()
        delegate?.setRedoButtonEnabled(redoImages.count > 0)
        delegate?.setUndoButtonEnabled(undoImages.count > 0)
    }

}
