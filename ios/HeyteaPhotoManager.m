//
//  HeyteaPhotoManager.m
//  heyteago
//
//  Created by Chris Zhou on 2020/7/8.
//  Copyright © 2020 Facebook. All rights reserved.
//

#import "HeyteaPhotoManager.h"

@implementation HeyteaPhotoManager

RCT_EXPORT_MODULE(HeyteaPhotoView);

RCT_EXPORT_VIEW_PROPERTY(data,NSArray);

RCT_EXPORT_VIEW_PROPERTY(selectedIndex, int);

RCT_EXPORT_VIEW_PROPERTY(onSingleTap, RCTBubblingEventBlock);

-(UIView *)view{
  PhotoView *view = [[PhotoView alloc] initWithFrame:CGRectZero];
  self.photoView = view;
  self.photoView.delegate = self;
  return view;
}

#pragma mark delegate
-(void)singleTap{

  [UIView animateWithDuration:.4 animations:^{
        self.photoView.alpha = 0.2;
    } completion:^(BOOL finished) {
       if(self.photoView.onSingleTap){
          self.photoView.onSingleTap(@{@"tap":@"single"});
        }
        [self.photoView removeFromSuperview];
  }]; 

}

@end
