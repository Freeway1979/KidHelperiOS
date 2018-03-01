//
//  iCloudManager.swift
//  KidHelper
//
//  Created by Liu PingAn on 01/03/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

import UIKit

class iCloudManager {

   class func getiCloudDocumentURL() -> NSURL? {
        if let url = FileManager.default.url(forUbiquityContainerIdentifier: nil) {
            return url.appendingPathComponent("Documents") as NSURL
        }
        return nil
    }
    
//    let metaQuery = NSMetadataQuery()
//    func listFile() {
//        metaQuery.searchScopes = [NSMetadataQueryUbiquitousDocumentsScope]
//        metaQuery.predicate = NSPredicate(value: true)
//        NotificationCenter.default.addObserver(self, selector: #selector(listReceived), name:NSNotification.Name.NSMetadataQueryDidFinishGathering, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(listReceived), name:NSNotification.Name.NSMetadataQueryDidUpdate, object: nil)
//        metaQuery.start()
//    }
//    @objc func listReceived() {
//        let results = metaQuery.results
//        for item in results {
//            let fileURL = (item as AnyObject).value(NSMetadataItemURLKey)
//        }
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.NSMetadataQueryDidFinishGathering, object: nil)
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.NSMetadataQueryDidUpdate, object: nil)
//        metaQuery.stop()
//    }
}

