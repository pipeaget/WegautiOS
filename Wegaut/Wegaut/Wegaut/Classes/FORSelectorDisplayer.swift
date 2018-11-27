//
//  FORSelectorDisplayer.swift
//  Wegaut
//
//  Created by Felipe Ortega on 11/26/18.
//  Copyright © 2018 Wegaut. All rights reserved.
//

import UIKit

protocol FORSelectorDisplayerDelegate {
    
    func updateSelectedIndex()->Int
}

@IBDesignable class FORSelectorDisplayer: UIControl {
    
    //MARK: - VARIABLES
    
    var delegate: FORSelectorDisplayerDelegate?

    //MARK: - IBINSPECTABLE VARIABLES
    
    @IBInspectable var borderColor: UIColor = UIColor.lightGray {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 1 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var options: String = "Marco,Polo" {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var selectedIndex: Int = 0 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var font: UIFont = UIFont.systemFont(ofSize: 18) {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var selectedTextColor: UIColor = UIColor.black {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var unselectedTextColor: UIColor = UIColor.darkGray {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var thumbColor: UIColor = UIColor.black {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var thumbHeight: CGFloat = 4 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var thumbCornerRadius: CGFloat = 4 {
        didSet {
            updateView()
        }
    }
    
    //MARK: - OUTLETS
    
    var vwThumb: UIView!
    
    //MARK: - VIEW LIFECYCLE
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        updateView()
    }
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        updateView()
    }
    
    //MARK: - FUNCTIONS
    
    func updateView() {
        
        self.subviews.forEach{$0.removeFromSuperview()}
        self.delegate = self
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        
        let arrOptions: [String] = options.components(separatedBy: ",")
        let widthPerItem: CGFloat = UIScreen.main.bounds.width / CGFloat(arrOptions.count)
        
        for (index, option) in arrOptions.enumerated() {
            
            let aView: UIView = UIView(frame: CGRect(x: widthPerItem * CGFloat(index),
                                                     y: 0,
                                                     width: widthPerItem,
                                                     height: frame.height))
            aView.tag = index
            let tgrSelector: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                             action: #selector(self.selectOption(view:)))
            aView.addGestureRecognizer(tgrSelector)
            
            let lblOption: UILabel = UILabel(frame: CGRect(x: 0,
                                                           y: 0,
                                                           width: widthPerItem,
                                                           height: frame.height))
            lblOption.textColor = index == selectedIndex ? selectedTextColor : unselectedTextColor
            lblOption.font = font
            lblOption.text = option
            lblOption.textAlignment = NSTextAlignment.center
            aView.addSubview(lblOption)
            self.addSubview(aView)
        }
        
        vwThumb = UIView(frame: CGRect(x: widthPerItem * CGFloat(selectedIndex),
                                                   y: frame.height - thumbHeight,
                                                   width: widthPerItem,
                                                   height: thumbHeight))
        vwThumb.backgroundColor = thumbColor
        vwThumb.layer.cornerRadius = thumbCornerRadius
        self.addSubview(vwThumb)
    }
    
    func updateThumb(index: Int) {
        
        let arrOptions: [String] = options.components(separatedBy: ",")
        let widthPerItem: CGFloat = UIScreen.main.bounds.width / CGFloat(arrOptions.count)
        vwThumb.frame = CGRect(x: widthPerItem * CGFloat(index),
                               y: frame.height - thumbHeight,
                               width: widthPerItem,
                               height: thumbHeight)
        selectedIndex = index
    }
    
    //MARK: - ACTIONS
    
    @objc func selectOption(view: UIView) {
        
        updateThumb(index: view.tag)
    }

}

extension FORSelectorDisplayer: FORSelectorDisplayerDelegate {
    
    func updateSelectedIndex() -> Int {
        
        return selectedIndex
    }
}
