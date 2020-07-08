//
//  HeyteaPhotoManager.h
//  heyteago
//
//  Created by Chris Zhou on 2020/7/8.
//  Copyright © 2020 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <React/RCTViewManager.h>
#import <React/RCTBridgeModule.h>
#import "PhotoView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HeyteaPhotoManager : RCTViewManager <PhotoViewDelegeate>

@property(nonatomic,strong)PhotoView *photoView;

@end

NS_ASSUME_NONNULL_END
