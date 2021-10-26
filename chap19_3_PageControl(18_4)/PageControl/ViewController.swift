//
//  ViewController.swift
//  PageControl
//
//  Created by inooph on 2021/10/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    var images = [ "01.png", "02.png", "03.png", "04.png", "05.png", "06.png" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0
        
        pageControl.pageIndicatorTintColor = UIColor.green
        pageControl.currentPageIndicatorTintColor = UIColor.red
        imgView.image = UIImage(named: images[0])
        
        // MARK: - [] 스와이프 제스처
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.left:
                print("1-1. case left : \(pageControl.currentPage)")
                if(pageControl.currentPage<pageControl.numberOfPages-1) {
                    pageControl.currentPage = pageControl.currentPage+1
                }
                print("1-2. case left : \(pageControl.currentPage)\n")
            
            case UISwipeGestureRecognizer.Direction.right:
                print("2-1. case right : \(pageControl.currentPage)")
                if(pageControl.currentPage>0) {
                    pageControl.currentPage = pageControl.currentPage - 1
                }
                print("2-2. case right : \(pageControl.currentPage)\n")
                
            default:
                break
            }
            
            imgView.image = UIImage(named: images[pageControl.currentPage])
        }
    }
    
    @IBAction func pageChanged(_ sender: UIPageControl) {
        imgView.image = UIImage(named: images[pageControl.currentPage])
    }
    
}

