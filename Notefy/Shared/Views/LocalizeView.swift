//
//  LocalizeView.swift
//  Notefy
//
//  Created by Talip Göksu on 21.04.18.
//  Copyright © 2018 Iman Studios. All rights reserved.
//

import UIKit

extension UIView {
    func localizeAllStrings() {
        if self is UIButton {
            if let button = self as? UIButton,
                let title = button.titleLabel?.text {
                button.setTitle(title.localized(), for: .normal)
            }
        } else if self is UILabel {
            if let label = self as? UILabel, let title = label.text {
                label.text = title.localized()
            }
        } else if self is UITextView {
            if let textView = self as? UITextView, let title = textView.text {
                textView.text = title.localized()
            }
        } else if self is UITextField {
            if let textField = self as? UITextField {
                let title = textField.text
                let placeholder = textField.placeholder
                textField.text = title?.localized()
                textField.placeholder = placeholder?.localized()
            }
        }
        else if self.subviews.count > 0 {
            subviews.forEach({ subview in
                subview.localizeAllStrings()
            })
        }
    }
}
