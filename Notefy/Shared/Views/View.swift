//
//  View.swift
//  Notefy
//
//  Created by Talip Göksu on 21.04.18.
//  Copyright © 2018 Iman Studios. All rights reserved.
//

import UIKit

class View: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonSetup()
    }
    
    func commonSetup() {
        localizeAllStrings()
    }
}

