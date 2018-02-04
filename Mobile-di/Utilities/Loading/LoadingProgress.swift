//
//  LoadingProgress.swift
//  Channel 40
//
//  Created by STARK on 04/02/17.
//  Copyright © 2017 Nabeel Gulzar. All rights reserved.
//

import UIKit

class LoadingProgress: UIView {
    
    @IBOutlet weak var progressImage: UIImageView!
    private static var obj: LoadingProgress? = nil
    static var flagClose    = false
    
    static var shared: LoadingProgress {
        if obj == nil {
            obj = UINib(nibName: "LoadingProgress", bundle: Bundle.main).instantiate(withOwner: nil, options: nil)[0] as? LoadingProgress
            obj?.frame = UIScreen.main.bounds
        }
        LoadingProgress.flagClose = false
        return obj!
    }
    
    @IBOutlet weak var loadingHead: UILabel!
    
   private func setup() {
        let window:UIWindow = UIApplication.shared.delegate!.window!!
        window.addSubview(self)
        
        self.transform = CGAffineTransform.identity.scaledBy(x: 0.0, y: 0.0)
        
        UIView.animate(withDuration: 0.01, delay: 0.01, options: .beginFromCurrentState, animations: {() -> Void in
            self.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
        }, completion: {(_ finished: Bool) -> Void in
        })
        
        let when = DispatchTime.now() + 30
        
        DispatchQueue.main.asyncAfter(deadline: when){
            self.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
            UIView.animate(withDuration: 0.01, delay: 0.01, options: .beginFromCurrentState, animations: {() -> Void in
                self.transform = CGAffineTransform.identity.scaledBy(x: 0.0, y: 0.0)
            }, completion: {(_ finished: Bool) -> Void in
                self.removeFromSuperview()
            })
        }
        
    }
    
    func showPI(message: String) {
        setup()
        loadingHead.text = message
        let jeremyGif = UIImage.gifImageWithName("loading_orange")
        progressImage.image = jeremyGif
        let when = DispatchTime.now() + 1
        LoadingProgress.flagClose = true
        DispatchQueue.main.asyncAfter(deadline: when){
            if LoadingProgress.flagClose {
                if (LoadingProgress.obj != nil) {
                    self.removeFromSuperview()
                }
            }
        }
    }
    
    func hide() {
        if LoadingProgress.flagClose {
            if (LoadingProgress.obj != nil) {
                self.removeFromSuperview()
            }
            LoadingProgress.flagClose = false
        }else{
            LoadingProgress.flagClose = true
        }
    }
    
    
    func setLabel(text:String) {
        loadingHead.text = text
    }
}


extension UIImage {
    public class func gifImageWithName(_ name: String) -> UIImage? {
        guard let bundleURL = Bundle.main
            .url(forResource: name, withExtension: "gif") else {
                print("SwiftGif: This image named \"\(name)\" does not exist")
                return nil
        }
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
            return nil
        }
        
        return gifImageWithData(imageData)
    }
    
    public class func gifImageWithData(_ data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            print("image doesn't exist")
            return nil
        }
        
        return UIImage.animatedImageWithSource(source)
    }
    
    class func delayForImageAtIndex(_ index: Int, source: CGImageSource!) -> Double {
        var delay = 0.1
        
        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifProperties: CFDictionary = unsafeBitCast(
            CFDictionaryGetValue(cfProperties,
                                 Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()),
            to: CFDictionary.self)
        
        var delayObject: AnyObject = unsafeBitCast(
            CFDictionaryGetValue(gifProperties,
                                 Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()),
            to: AnyObject.self)
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties,
                                                             Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
        }
        
        delay = delayObject as! Double
        
        if delay < 0.1 {
            delay = 0.1
        }
        
        return delay
    }
    
    class func gcdForPair(_ a: Int?, _ b: Int?) -> Int {
        var a = a
        var b = b
        if b == nil || a == nil {
            if b != nil {
                return b!
            } else if a != nil {
                return a!
            } else {
                return 0
            }
        }
        
        if a! < b! {
            let c = a
            a = b
            b = c
        }
        
        var rest: Int
        while true {
            rest = a! % b!
            
            if rest == 0 {
                return b!
            } else {
                a = b
                b = rest
            }
        }
    }
    
    class func gcdForArray(_ array: Array<Int>) -> Int {
        if array.isEmpty {
            return 1
        }
        
        var gcd = array[0]
        
        for val in array {
            gcd = UIImage.gcdForPair(val, gcd)
        }
        
        return gcd
    }
    
    class func animatedImageWithSource(_ source: CGImageSource) -> UIImage? {
        let count = CGImageSourceGetCount(source)
        var images = [CGImage]()
        var delays = [Int]()
        
        for i in 0..<count {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(image)
            }
            
            let delaySeconds = UIImage.delayForImageAtIndex(Int(i),
                                                            source: source)
            delays.append(Int(delaySeconds * 1000.0)) // Seconds to ms
        }
        
        let duration: Int = {
            var sum = 0
            
            for val: Int in delays {
                sum += val
            }
            
            return sum
        }()
        
        let gcd = gcdForArray(delays)
        var frames = [UIImage]()
        
        var frame: UIImage
        var frameCount: Int
        for i in 0..<count {
            frame = UIImage(cgImage: images[Int(i)])
            frameCount = Int(delays[Int(i)] / gcd)
            
            for _ in 0..<frameCount {
                frames.append(frame)
            }
        }
        
        let animation = UIImage.animatedImage(with: frames,
                                              duration: Double(duration) / 4000.0)
        
        return animation
    }
}
