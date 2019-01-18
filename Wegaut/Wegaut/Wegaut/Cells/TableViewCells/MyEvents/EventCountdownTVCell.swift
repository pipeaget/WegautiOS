//
//  EventCountdownTVCell.swift
//  wegaut
//
//  Created by Felipe Ortega on 6/12/18.
//  Copyright © 2018 InGenious. All rights reserved.
//

import UIKit
import SDWebImage

class EventCountdownTVCell: UITableViewCell {
    
    //MARK: - VARIABLES
    
    var currentEvent: Event?{
        didSet{
            drawCell()
        }
    }
    /*lazy var countdownView: BRCountDownView = {
        let countdownView = BRCountDownView(timeSeconds: 100000)
        countdownView.animationStyle = .slideInFromBottom
        
        /** you can make animate that you would like to perform in this closure if you would.
         To do this, you should change animationStyle property to 'true'.
         */
        //    countdownView.animationStyle = .custom
        //    countdownView.customAnimation = {
        //      [unowned self] animateView, duration in
        //      UIView.animate(withDuration: duration, animations: {
        //        animateView.alpha = 0.0
        //      }, completion:{ finished in
        //        if finished {
        //          animateView.alpha = 1.0
        //        }
        //      })
        //    }
        
        countdownView.didFinish = {
            [unowned self] (countdownView) -> Void in
            
            DispatchQueue.main.async {
                print("countdown is finished...")
            }
            
            /** you can again repeat countdown with seconds you want whenever you want. */
            // self.countdownView.repeatCountDown(in: 5)
        }
        
        countdownView.didRepeat = {
            [unowned self] (countdownView) -> Void in
            // it is fired when count-down repeat gets started.
            DispatchQueue.main.async {
                print("countdown is repeated...")
            }
        }
        
        countdownView.didResume = {
            [unowned self] (countdownView) -> Void in
            /**
             do any task here if you need.
             */
            print("didResume!")
        }
        
        countdownView.didTerminate = {
            [unowned self] (countdownView) -> Void in
            /**
             do any task here if you need.
             */
            print("didTerminate!")
        }
        
        countdownView.didStop = {
            [unowned self] (countdownView) -> Void in
            /**
             do any task here if you need.
             */
            print("didStop!")
        }
        
        countdownView.isUserInteractionEnabled = true
        countdownView.didTouchBegin = {
            [unowned self] sender in
            print("didTouchBegin!?")
        }
        
        countdownView.didTouchEnd = {
            [unowned self] sender in
            print("didTouchEnd!?")
        }
        
        return countdownView
    }()*/
    
    //MARK: - OUTLETS
    
    @IBOutlet weak var vwTimer: UIView!
    @IBOutlet weak var imgvwEvent: UIImageView!
    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var lblEventAddress: UILabel!
    @IBOutlet weak var lblEventDate: UILabel!
    
    //MARK: - VIEW LIFECYCLE

    override func awakeFromNib() {
        
        super.awakeFromNib()
        self.selectionStyle = UITableViewCell.SelectionStyle.none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - FUNCTIONS
    
    func drawCell(){
        
        guard let anEvent: Event = currentEvent else{
           
            return
        }
        /*if let anURL = URL(string: anEvent.eveImageURL){
            
            imgvwEvent.sd_setImage(with: anURL,
                                   placeholderImage: #imageLiteral(resourceName: "BGLogo"),
                                   options: SDWebImageOptions.highPriority,
                                   completed: nil)
        }*/
        imgvwEvent.image = UIImage(named: anEvent.eveImageURL)
        imgvwEvent.clipsToBounds = true
        lblEventName.text = anEvent.eveName
        let strAddress: NSMutableAttributedString = NSMutableAttributedString(string: anEvent.eveAddress)
        lblEventAddress.attributedText = strAddress.getStringWith(anImage: #imageLiteral(resourceName: "ICAddress"),
                                                                  isInLeftPosition: true,
                                                                  currentFont: UIFont.systemFont(ofSize: 8))
        lblEventDate.text = anEvent.eveDate
        
        /*vwTimer.
        
        countdownView.layer.borderWidth = 1.0
        countdownView.layer.borderColor = UIColor.black.cgColor
        
        // get center.
        countdownView.frame = CGRect(x: 0,
                                     y: 0,
                                     width: 189,
                                     height: 74)
        self.vwTimer.addSubview(countdownView)*/
    }
}
