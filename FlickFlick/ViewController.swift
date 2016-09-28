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

final class ViewController: UIViewController {
    
    @IBOutlet private weak var arrowsLabel: UILabel!
    
    private let dic: [UISwipeGestureRecognizerDirection: String] = [.right: "→", .left: "←", .up: "↑", .down: "↓"]
    
    private var directions = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for dir in [UISwipeGestureRecognizerDirection](dic.keys) {
            let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.didSwipe(_:)))
            swipeGestureRecognizer.direction = dir
            view.addGestureRecognizer(swipeGestureRecognizer)
        }
        
        newGame()
    }
    
    func didSwipe(_ sender: UISwipeGestureRecognizer) { // private

        if dic[sender.direction] == directions.first! {
            directions.remove(at: 0)
            arrowsLabel.attributedText = makeHighlightedStringFromArray(directions)
        }
        
        if directions.isEmpty {
            newGame()
        }
    }
    
    private func produceArrayCombination() -> [String] {
        
        let arrows = [String](dic.values)
        return (0 ..< 4).map {_ in arrows[Int(arc4random_uniform(UInt32(4)))]}
    }
    
    // ["→", "←", "↑", "↑"] -> "→←↑↑"
    private func makeSimpleStringFromArray(_ array: [String]) -> String {
        return array.joined(separator: "")
    }
    
    // show combination and highlight the target(first) arrow
    private func makeHighlightedStringFromArray(_ array: [String]) -> NSMutableAttributedString {

        let attributedStrings = array.enumerated().map { (i, ele) -> NSAttributedString in
            if i == 0 {
                return NSAttributedString(string: ele, attributes: [NSForegroundColorAttributeName: UIColor.red])
            } else {
                return NSAttributedString(string: ele)
            }
        }
        
        return attributedStrings.reduce(NSMutableAttributedString(string: "")) { (sum, now) -> NSMutableAttributedString in
            sum.append(now)
            return sum
        }
    }
    
    private func newGame() {
        directions = produceArrayCombination()
//        arrowsLabel.text = makeSimpleStringFromArray(directions)
        arrowsLabel.attributedText = makeHighlightedStringFromArray(directions)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
