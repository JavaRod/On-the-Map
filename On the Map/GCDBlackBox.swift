//
//  GCDBlackBox.swift
//  On the Map
//
//  Created by Rodrick Musser on 8/7/16.
//  Copyright © 2016 RodCo. All rights reserved.
//

import Foundation


func performUIUpdatesOnMain(updates: () -> Void) {
    dispatch_async(dispatch_get_main_queue()) {
        updates()
    }
}