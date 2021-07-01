//
//  DefaultButton.swift
//  CookingApp
//
//  Created by Christian Slanzi on 30.04.21.
//

import UIKit

public class DefaultButton: UIButton {
    
    public init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    public init(title: String, target: Any, selector: Selector) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(title, for: .normal)
        setTitleColor(.systemBlue, for: .normal)
        addTarget(target, action: selector, for: .touchUpInside)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
