//
//  ViewController.swift
//  CollectionViewSample
//
//  Created by Masanori Kuze on 2016/01/09.
//  Copyright © 2016年 Masanori Kuze. All rights reserved.
//

import UIKit
import AVFoundation
import AssetsLibrary

class ViewController: UICollectionViewController {
    
    struct Capture {
        var picture : CGImageRef
        var time : Float64
    }
    
    var generator : AVAssetImageGenerator!
    var captureAry : [Capture]!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        if let path = NSBundle.mainBundle().URLForResource("IMG_0727", withExtension: "mp4") {
            do {
                let avAsset = AVURLAsset(URL: path, options: nil)
                
                // assetから画像をキャプチャーする為のジュネレーターを生成.
                generator = AVAssetImageGenerator(asset: avAsset)
                
                let runningTime = Int64(CMTimeGetSeconds(avAsset.duration))
                
                let time : CMTime = CMTimeMake(runningTime, 10)
                var capturedTime : CMTime = kCMTimeZero
                
                captureAry = []
                
                for _ in 0...9 {
                    let capturedImage : CGImageRef! = try! generator.copyCGImageAtTime(capturedTime, actualTime: nil)
                    
                    let capture = Capture(picture: capturedImage, time: CMTimeGetSeconds(capturedTime))
                    captureAry.append(capture)
                    
                    capturedTime = CMTimeAdd(capturedTime, time)
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //1
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //2
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    //3
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        //1
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CustomCell
        
        
        let capture = captureAry[indexPath.row] as Capture
        let image2 = UIImage(CGImage: capture.picture as CGImageRef)
        
        var strSeekTime = ""
        let seektime = Int(round(capture.time))
        if (seektime < 60){
            strSeekTime = "0:" + (NSString(format: "%02d", Int(seektime)) as String)
        } else {
            strSeekTime = String(Int(seektime/60)) + ":" + (NSString(format: "%02d", Int(seektime%60)) as String)
        }
        
        let text = strSeekTime
        
        //3
        cell.imageView.image = image2
        cell.timeLabel.text = text
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        NSLog("select")
        //
        //        NSUserDefaults.standardUserDefaults().setObject(indexPath.row, forKey: "time")
        //        NSUserDefaults.standardUserDefaults().synchronize()
        //
        //        performSegueWithIdentifier("showDetail", sender: self)
    }
    
    override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        NSLog("did")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        NSLog("segue")
        
        let index : NSIndexPath = (self.collectionView?.indexPathForCell(sender as! UICollectionViewCell))!
        
        let capture = captureAry[index.row]
        let value : UInt64 = UInt64(capture.time*100)
        
        
        NSUserDefaults.standardUserDefaults().setObject(NSNumber(unsignedLongLong: value), forKey: "time")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
}

