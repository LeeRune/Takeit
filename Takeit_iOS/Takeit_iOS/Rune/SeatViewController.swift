//
//  SeatViewController.swift
//  SeatTest
//
//  Created by 李易潤 on 2021/1/31.
//

import UIKit

class SeatViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var seatID: UILabel!
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    @IBOutlet var memberSelection: [UIButton]!
    @IBOutlet weak var screen: UIView!
    @IBOutlet weak var seatCollectionView: UICollectionView!
    
    var classTitle = ["Platinum","Gold","Silver"]
    var seatLayout = ["Platinum":[1,1,1,1,1,1,1,2,2,1],
                      "Gold":[2,1,1,1,1,1,1,2,2,2,
                              0,2,1,1,1,1,1,2,2,0,
                              0,1,1,1,1,1,1,2,2,0],
                      "Silver":[1,1,1,1,1,1,1,2,2,1,
                                1,1,1,1,1,1,1,2,2,1,
                                1,1,1,1,1,1,1,2,2,1,
                                0,1,1,1,2,1,1,1,1,0,
                                0,1,2,2,2,2,1,1,1,0,
                                0,2,2,1,1,1,2,2,2,0]]
    var seatCount: Int = 0
    var scView:UIScrollView!
    let buttonPadding:CGFloat = 10
    var xOffset:CGFloat = 10
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0...memberSelection.count-1{
            memberSelection[i].contentVerticalAlignment = .fill
            memberSelection[i].contentHorizontalAlignment = .fill
        }
        
        screen.layer.cornerRadius = 3
        screen.layer.masksToBounds = true
        
//        addScrollFood()

    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return classTitle.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (seatLayout[classTitle[section]]?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let deviceWidth = (view.frame.width/10)-10
        return CGSize(width: deviceWidth, height: deviceWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "seatCell", for: indexPath) as! seatCell
        if seatLayout[classTitle[indexPath.section]]![indexPath.row] == 0 {
            cell.seat.image = nil
        }else if seatLayout[classTitle[indexPath.section]]![indexPath.row] == 1 {
            cell.seat.image = #imageLiteral(resourceName: "filled")
        }else if seatLayout[classTitle[indexPath.section]]![indexPath.row] == 2 {
            cell.seat.image = #imageLiteral(resourceName: "unFilled")
        }else{
            cell.seat.image = #imageLiteral(resourceName: "selected")
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if seatLayout[classTitle[indexPath.section]]![indexPath.row] != 0 && seatLayout[classTitle[indexPath.section]]![indexPath.row] != 1 {
            if seatLayout[classTitle[indexPath.section]]![indexPath.row] != 3{
                seatLayout[classTitle[indexPath.section]]![indexPath.row] = 3
                seatCount += 1
                if seatCount == 1{
                    showBottomView()
                }
//                setSeatnPrice()
            }else{
                seatLayout[classTitle[indexPath.section]]![indexPath.row] = 2
                seatCount -= 1
                if seatCount == 0{
                    hideBottomView()
                }
//                setSeatnPrice()
            }
            seatCollectionView.reloadData()
        }
    }
    
    func showBottomView(){
        seatCollectionView.scrollsToTop = true
        UIView.animate(withDuration: 0.5, animations: {
            self.bottomViewHeight.constant = 50
            self.view.layoutIfNeeded()
        }) { (success) in
        }
    }
    func hideBottomView(){
        UIView.animate(withDuration: 0.5, animations: {
            self.bottomViewHeight.constant = 0
            self.view.layoutIfNeeded()
        }) { (success) in
        }
    }
    
    func addScrollFood(){
        scView = UIScrollView(frame: CGRect(x: 0, y: 570, width: view.bounds.width, height: 180))
        view.addSubview(scView)
        
//        scView.backgroundColor = UIColor.blue
        scView.translatesAutoresizingMaskIntoConstraints = false
        
        for i in 0 ... 10 {
            let button = UIButton()
            let button2 = UIButton()
            let button3 = UIButton()
            let label = UILabel()
            button.tag = i
            button.backgroundColor = UIColor.darkGray
            button.setTitle("\(i)", for: .normal)
            //button.addTarget(self, action: #selector(btnTouch), for: UIControlEvents.touchUpInside)
            button2.tag = i
//            button2.backgroundColor = UIColor.darkGray
//            button2.setTitle("\(i)", for: .normal)
            button.frame = CGRect(x: xOffset, y: CGFloat(buttonPadding), width: 120, height: 80)
            button2.frame = CGRect(x: xOffset, y: CGFloat(buttonPadding) + button.frame.height, width: 40 , height: 40)
            button3.frame = CGRect(x: xOffset + button2.frame.width + 40, y: CGFloat(buttonPadding) + button.frame.height, width: 40, height: 40)
            label.frame = CGRect(x: xOffset + button2.frame.width, y: CGFloat(buttonPadding) + button.frame.height, width: 40, height: 40)
            button2.setImage(UIImage(systemName: "plus.circle"), for: .normal)
            button3.setImage(UIImage(systemName: "minus.circle"), for: .normal)
//            button2.backgroundColor = UIColor.darkGray
//            button3.backgroundColor = UIColor.darkGray
//            label.backgroundColor = UIColor.white
            button2.imageView?.contentMode = .scaleAspectFit
            button3.imageView?.contentMode = UIView.ContentMode.scaleAspectFill
            label.text = "12"
            label.textAlignment = NSTextAlignment.center
            
            xOffset = xOffset + CGFloat(buttonPadding) + button.frame.size.width
            scView.addSubview(button)
            scView.addSubview(button2)
            
            scView.addSubview(label)
            scView.addSubview(button3)
        }
        
        scView.contentSize = CGSize(width: xOffset, height: scView.frame.height)
    }
}
