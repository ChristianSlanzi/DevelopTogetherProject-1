//
//  CategoriesView.swift
//  CookingApp
//
//  Created by Christian Slanzi on 02.06.21.
//

import UIKit
import CommonUI

class CategoriesView: CustomView {
    
    var buttons = [UIButton]()
    
    override func setupViews() {
        super.setupViews()
        self.translatesAutoresizingMaskIntoConstraints = false
        // set some values for the width and height of each button
       
    }
    
    override func setupConstraints() {
        super.setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let numRows = 4
        let numColoums = 2
        
        let width: CGFloat = self.frame.width / CGFloat(numColoums)
        let height: CGFloat = 50.0
        let padding: CGFloat = 20.0

        // create 8 buttons as a 4x2 grid
        for row in 0..<numRows {
            for col in 0..<numColoums {
                // create a new button and give it a big font size
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
                
                letterButton.backgroundColor = .cyan

                // give the button some temporary text so we can see it on-screen
                letterButton.setTitle("WWW", for: .normal)

                // calculate the frame of this button using its column and row
                let frame = CGRect(x: CGFloat(col) * (width+padding), y: CGFloat(row) * (height+padding), width: width-padding, height: height)
                letterButton.frame = frame

                // add it to the buttons view
                addSubview(letterButton)

                // and also to our letterButtons array
                buttons.append(letterButton)
            }
        }
    }
}

