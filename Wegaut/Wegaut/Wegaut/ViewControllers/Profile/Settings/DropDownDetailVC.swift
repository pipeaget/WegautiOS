//
//  DropDownDetailVC.swift
//  wegaut
//
//  Created by Felipe Ortega on 5/22/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit

enum DropDownType {
    
    case FAQ
    case SoftwareLicenses
    
    var description: String {
        
        switch self {
            
        case DropDownType.FAQ:              return "DDD_FAQ"
        case DropDownType.SoftwareLicenses: return "DDD_SL"
        }
    }
}

class DropDownDetailVC: UIViewController {
    
    //MARK: - VARIABLES
    
    var selectedCellIndex:Int!
    var currentInfoType:DropDownType?
    
    //MARK: - OUTLETS

    @IBOutlet weak var tvDropDownDetail: UITableView!
    
    //MARK: - VIEW LIFECYCLE
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tvDropDownDetail.dataSource = self
        tvDropDownDetail.delegate = self
        selectedCellIndex = 99
        self.addImageLogoToNavBar()
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    func getCorrespondingDropDownOptions()->[DropDownOption]?{
        
        guard let anInfoType = currentInfoType else{
            
            return nil
        }
        
        switch anInfoType {
            
        case DropDownType.FAQ:
            return DropDownOption.getFAQ()
            
        case DropDownType.SoftwareLicenses:
            return DropDownOption.getSoftwareLicenses()
        }
    }
    
    //MARK: FUNCTIONS
    
    /// Used to obtain the corresponding height for the current cell data according to it's content and selestion state.
    ///
    /// - Parameters:
    ///   - aDropDownOption: The current DropDownOption element for the cell.
    ///   - includesDesc: An indicator that describes if the current cell must be expanded or not.
    /// - Returns: The corresponding height for the cell.
    func getCellHeightAccordingTo(aDropDownOption: DropDownOption, includesDesc: Bool)->CGFloat{
        
        let attributedName:NSAttributedString = NSAttributedString(string: aDropDownOption.DDHeader,
                                                                   attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)])
        let rectName:CGRect = attributedName.boundingRect(with: CGSize(width: self.view.frame.width - 60,
                                                                       height: CGFloat.greatestFiniteMagnitude),
                                                          options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                          context: nil)
        let attributedContent:NSAttributedString = NSAttributedString(string: aDropDownOption.DDContent,
                                                                      attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)])
        let rectContent:CGRect = attributedContent.boundingRect(with: CGSize(width: self.view.frame.width - 30,
                                                                       height: CGFloat.greatestFiniteMagnitude),
                                                          options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                          context: nil)
        let requiredSize:CGFloat = includesDesc ? rectName.height + rectContent.height + 60 : rectName.height + 40
        return requiredSize
    }
}

//MARK: - EXTENSIONS

//MARK: - UITableViewDataSource & UITableViewDelegate

extension DropDownDetailVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let screenSize: CGSize = UIScreen.main.bounds.size
        let vwHeader: UIView = UIView(frame: CGRect(x: 0,
                                                    y: 0,
                                                    width: screenSize.width,
                                                    height: 60))
        let lblHeader: UILabel = UILabel(frame: CGRect(x: 10,
                                                       y: 15,
                                                       width: screenSize.width - 20,
                                                       height: 30))
        lblHeader.font = UIFont(name: "Avenir-Heavy", size: 25) ?? UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
        lblHeader.textAlignment = NSTextAlignment.center
        lblHeader.textColor = UIColor.white
        lblHeader.adjustsFontSizeToFitWidth = true
        vwHeader.backgroundColor = UIColor.deepPurple
        vwHeader.addSubview(lblHeader)
        
        guard let arrOptions = getCorrespondingDropDownOptions() else{
            
            lblHeader.text = "DDD_INV_SEC".localized
            return vwHeader
        }
        
        if arrOptions.count == 0{
            
            lblHeader.text = "DDD_EMP_SEC".localized
            return vwHeader
        }else{
            
            lblHeader.text = currentInfoType!.description.localized
            return vwHeader
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 60
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let arrDropDownOptions = getCorrespondingDropDownOptions() else{
            
            return 0
        }
        return arrDropDownOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let aCell:DropDownTVCell = tableView.dequeueReusableCell(withIdentifier: "DropDownCell", for: indexPath) as! DropDownTVCell
        if let anOptions = getCorrespondingDropDownOptions(){
            
            aCell.setupCell(aDropDownOption: anOptions[indexPath.row], isExpanded: selectedCellIndex == indexPath.row ? true : false)
        }
        aCell.selectionStyle = UITableViewCell.SelectionStyle.none
        return aCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if let anOptions = getCorrespondingDropDownOptions(){
            
            return getCellHeightAccordingTo(aDropDownOption: anOptions[indexPath.row], includesDesc: selectedCellIndex == indexPath.row ? true : false)
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tvDropDownDetail.beginUpdates()
        selectedCellIndex = selectedCellIndex == indexPath.row ? 99 : indexPath.row
        tvDropDownDetail.endUpdates()
        tvDropDownDetail.reloadData()
        tvDropDownDetail.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.top, animated: true)
    }
    
}
