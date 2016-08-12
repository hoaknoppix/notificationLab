//
//  ViewController.swift
//  notificationLab
//
//  Created by hoaqt on 8/12/16.
//  Copyright © 2016 com.noron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pokeball: UIImageView!
    @IBOutlet weak var mewtwo: UITouchImageView!
    @IBOutlet weak var dragonnite: UITouchImageView!
    @IBOutlet weak var raichu: UITouchImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

extension ViewController: UITouchImageViewDelegate {

    func onTouch(imageView: UITouchImageView) {
        
    }
}

