//
//  ViewController.swift
//  Wed28marsIosThreads
//
//  Created by David Svensson on 2018-03-28.
//  Copyright © 2018 David Svensson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var inactiveQueue: DispatchQueue!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //simpleQueue()
        
        //queuesWithPriority()
        
//        concurrentQueue()
//        print("kön är skapad")
//        inactiveQueue.activate()
        
        //deleyedQueue()
        
        //fetchImage()
  
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func simpleQueue() {
        let queue = DispatchQueue(label: "myQueue")
     
        queue.async {
            for i in 0..<10 {
                print("🔴  \(i)")
            }
        }
        
        for i in 0..<10 {
            print("🔵 \(i)")
        }
    }
    
    func queuesWithPriority() {
        let queue1 = DispatchQueue(label: "queue1", qos: .userInitiated)
        let queue2 = DispatchQueue(label: "queue2", qos: .utility)
        
     
        queue1.async {
            for i in 0..<10 {
                print("🔴  \(i)")
            }
        }
        
        queue2.async {
            for i in 0..<10 {
                print("🔵 \(i)")
            }
        }
        
        for i in 0..<10 {
            print("⚫️ \(i)")
        }
    }
    
    func concurrentQueue() {
        let queue = DispatchQueue(label: "queue", qos: .utility, attributes: [.initiallyInactive, .concurrent])
        inactiveQueue = queue
        
        queue.async {
            for i in 0..<10 {
                print("🔴  \(i)")
            }
        }
        
        queue.async {
            for i in 0..<10 {
                print("🔵 \(i)")
            }
        }
        
        queue.async {
            for i in 0..<10 {
                print("⚫️ \(i)")
            }
        }
    }
    
    func deleyedQueue() {
        let queue = DispatchQueue(label: "myQueue", qos: .userInitiated)
        
        print("⚫️")
        
       // let timeDelay = DispatchTimeInterval.seconds(3)
        
        queue.asyncAfter(deadline: .now() + 2) {
             print("🔵")
        }
     
    }
    
    func fetchImage() {
        let imageUrl = URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Cat03.jpg/220px-Cat03.jpg")
        
        URLSession(configuration: .default).dataTask(with: imageUrl!, completionHandler: { (imageData,response, error) in
            
            if let data = imageData {
                print("Bild nedladdad")
               
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            }
        }).resume()
    }
}

