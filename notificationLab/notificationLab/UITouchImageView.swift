//
//  UIDrawingImageView.swift
//  NotificationLab
//
//  Created by hoaqt on 8/11/16.
//  Copyright © 2016 Dang Quoc Huy. All rights reserved.
//

import UIKit

protocol UITouchImageViewDelegate {
    func onTouch(imageView: UITouchImageView)

}

class UITouchImageView: UIImageView {
    
    var delegate: UITouchImageViewDelegate?

    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        delegate?.onTouch(self)
    }
}
