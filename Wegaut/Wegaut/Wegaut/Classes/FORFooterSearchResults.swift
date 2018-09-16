//
//  FORFooterSearchResults.swift
//  wegaut
//
//  Created by Felipe Ortega on 6/12/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit

class FORFooterSearchResults: UIView {

    //MARK: - VARIABLES
    
    let lblFilter: UILabel = UILabel()
    
    //MARK: - INITIALIZERS
    
    override public init(frame: CGRect) {
        
        super.init(frame: frame)
        configureView()
    }
    
    required public init?(coder: NSCoder) {
        
        super.init(coder: coder)
        configureView()
    }
    
    //MARK: - FUNCTIONS
    
    /// Used to set the default view visual configuration.
    func configureView() {
        
        self.backgroundColor = UIColor.deepPurple
        self.alpha = 0.0
        lblFilter.textAlignment = NSTextAlignment.center
        lblFilter.textColor = UIColor.white
        lblFilter.alpha = 0.0
        self.addSubview(lblFilter)
    }
    
    override func draw(_ rect: CGRect) {
        
        lblFilter.frame = self.bounds
    }
    
    //MARK: - ANIMATIONS
    
    /// Used to dismiss the FORFooterSearchResults with an animation.
    fileprivate func hideFooter() {
        
        UIView.animate(withDuration: 0.7) {[unowned self] in
            self.alpha = 0.0
            self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 0)
            self.lblFilter.alpha = 0.0
        }
    }
    
    /// Used to display the FORFooterSearchResults with an animation.
    fileprivate func showFooter() {
        
        UIView.animate(withDuration: 0.7) {[unowned self] in
            self.alpha = 1.0
            self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 50)
            self.lblFilter.alpha = 1.0
        }
    }
}

extension FORFooterSearchResults {
    
    /// Used to empty the LblFilter and hide the FORFooterSearchResults.
    public func setNotFiltering() {
        
        lblFilter.text = ""
        hideFooter()
    }
    
    /// Used to manage the UI of FORFooterSearchResults according to the obtained results.
    ///
    /// - Parameters:
    ///   - filteredItemCount: The number of filtered items.
    ///   - totalItemCount: The number of all the items.
    public func setIsFilteringToShow(filteredItemCount: Int, of totalItemCount: Int) {
        
        if (filteredItemCount == totalItemCount) {
            setNotFiltering()
        }else if (filteredItemCount == 0){
            lblFilter.text = "No se encontraron coincidencias"
            showFooter()
        }else{
            lblFilter.text = filteredItemCount == 1 ? "\(filteredItemCount) elemento encontrado de \(totalItemCount)" : "\(filteredItemCount) elementos encontrados de \(totalItemCount)"
            showFooter()
        }
    }
}
