//
//  ViewController.swift
//  FlickFlick
//
//  Created by Ken Tominaga on 7/22/15.
//  Copyright (c) 2015 ken0nek. All rights reserved.
//

import UIKit

extension UISwipeGestureRecognizerDirection: Hashable {
    public var hashValue: Int {
        return self.rawValue.hashValue
    }
}

class ViewController: UIViewController {
    
    @IBOutlet private weak var arrowsLabel: UILabel!
    
    // key : UISwipeGestureRecognizerDirection.rawValue
//    private let dic: [UInt: String] = [1: "→", 2: "←", 4: "↑", 8: "↓"]
    // key : UISwipeGestureRecognizerDirection
    private let dic2: [UISwipeGestureRecognizerDirection: String] = [.Right: "→", .Left: "←", .Up: "↑", .Down: "↓"]
    
    private var directions = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
//        for i in [UInt](dic.keys) {
//            let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "didSwipe:")
//            let direction = UISwipeGestureRecognizerDirection(i)
//            swipeGestureRecognizer.direction = direction
//            view.addGestureRecognizer(swipeGestureRecognizer)
//        }
        
        for dir in [UISwipeGestureRecognizerDirection](dic2.keys) {
            let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "didSwipe:")
            swipeGestureRecognizer.direction = dir
            view.addGestureRecognizer(swipeGestureRecognizer)
        }
        
        newGame()
    }

    func didSwipe(sender: UISwipeGestureRecognizer) { // private
//        if dic[sender.direction.rawValue] == directions.first! {
//            directions.removeAtIndex(0)
//            arrowsLabel.text = makeSimpleStringFromArray(directions)
////            arrowsLabel.attributedText = makeHighlightedStringFromArray(directions)
//        }
        if dic2[sender.direction] == directions.first! {
            directions.removeAtIndex(0)
            arrowsLabel.text = makeSimpleStringFromArray(directions)
//            arrowsLabel.attributedText = makeHighlightedStringFromArray(directions)
        }
        
        if directions.isEmpty {
            newGame()
        }
    }
    
    private func produceArrayCombination() -> [String] {
//        var dirs = [String]()
//        let arrows = [String](dic.values)
//        for _ in 0 ..< 4 {
//            dirs.append(arrows[Int(arc4random_uniform(UInt32(4)))])
//        }
//        return dirs
        let arrows = [String](dic2.values)
        return Array(0..<4).map{_ in arrows[Int(arc4random_uniform(UInt32(4)))]}
//        var dirs = [String]()
//        let arrows = [String](dic2.values)
//        for _ in 0 ..< 4 {
//            dirs.append(arrows[Int(arc4random_uniform(UInt32(4)))])
//        }
//        return dirs
    }
    
    // ["→", "←", "↑", "↑"] -> "→←↑↑"
    private func makeSimpleStringFromArray(array: [String]) -> String {
        return "".join(array)
    }
    
    // show combination and highlight the target(first) arrow
    private func makeHighlightedStringFromArray(array: [String]) -> NSMutableAttributedString {
        var labelText = NSMutableAttributedString()
        
        for i in 0..<array.count {
            
            let attributedString: NSAttributedString
            if i == 0 {
                attributedString = NSAttributedString(string: "\(array[i])", attributes: [NSForegroundColorAttributeName: UIColor.redColor()])
            } else {
                attributedString = NSAttributedString(string: "\(array[i])")
            }
            
            labelText.appendAttributedString(attributedString)
        }
        
        return labelText
    }
    
    private func newGame() {
        directions = produceArrayCombination()
        arrowsLabel.text = makeSimpleStringFromArray(directions)
//        arrowsLabel.attributedText = makeHighlightedStringFromArray(directions)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

