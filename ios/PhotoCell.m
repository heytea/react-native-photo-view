//
//  PhotoCellCollectionViewCell.m
//  heyteago
//
//  Created by Chris Zhou on 2020/7/8.
//  Copyright © 2020 Facebook. All rights reserved.
//

#import "PhotoCell.h"
#import <SDWebImage.h>

@interface PhotoCell()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIImageView *imageView;

@end


@implementation PhotoCell

-(instancetype)initWithFrame:(CGRect)frame{
  self = [super initWithFrame:frame];
  if (self) {
    [self setupSubviews];
  }
  return  self;
}

-(void)setupSubviews{
  [self.contentView addSubview:self.scrollView];
  [self.scrollView addSubview:self.imageView];
  
  UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
  UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
  UIPinchGestureRecognizer *pinchTap = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchAction:)];
  doubleTap.numberOfTapsRequired = 2;
  [singleTap requireGestureRecognizerToFail:doubleTap];
  [self.scrollView addGestureRecognizer:singleTap];
  [self.scrollView addGestureRecognizer:doubleTap];
  [self.scrollView addGestureRecognizer:pinchTap];
}

// gesture
/**
 让代理去实现单击手势  单点隐藏
 */
-(void)singleTap:(UITapGestureRecognizer *)singleTap{
  self.tabBlock();
}

-(void)doubleTap:(UITapGestureRecognizer *)doubleTap{
  if (self.scrollView.zoomScale > 1) {
    [self.scrollView setZoomScale:1 animated:YES];
  }else{
    CGPoint touchPoint = [doubleTap locationInView:self.imageView];
    CGFloat newZoomScale = self.scrollView.maximumZoomScale;
    CGFloat xSize = self.frame.size.width / newZoomScale;
    CGFloat ySize = self.frame.size.height / newZoomScale;
    [self.scrollView zoomToRect:CGRectMake(touchPoint.x - xSize/2, touchPoint.y -ySize/2, xSize, ySize) animated:YES];
  }
}

-(void)pinchAction:(UIPinchGestureRecognizer *)pinch{
  self.imageView.transform  = CGAffineTransformScale(self.imageView.transform, pinch.scale, pinch.scale);
  pinch.scale = 1;
}

/**
 getter
 */
-(UIScrollView *)scrollView{
  if (!_scrollView) {
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = [UIColor blackColor];
    _scrollView.maximumZoomScale = 2;
    _scrollView.minimumZoomScale = 1;
    _scrollView.delegate = self;
  }
  return _scrollView;
}

-(UIImageView *)imageView{
  if (!_imageView) {
    _imageView = [[UIImageView alloc] init];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.userInteractionEnabled = YES;
    _imageView.multipleTouchEnabled = YES;
  }
  return _imageView;
}

/**
 setter
 */
-(void)setImageUrl:(NSString *)imageUrl{
  if (imageUrl == _imageUrl) return;
  _imageUrl = imageUrl;
  [self.scrollView setZoomScale:1 animated:NO];
  [self.imageView sd_setImageWithURL:[NSURL URLWithString:_imageUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
    
  }];
  [self resizeSubviews];
  
}

/**
 overwrrite
 */
-(void)layoutSubviews{
  [super layoutSubviews];
  [self.scrollView setZoomScale:1 animated:YES];
  self.scrollView.frame = self.contentView.bounds;
  self.imageView.frame = self.contentView.bounds;
}

-(void)resizeSubviews{
  
}

#pragma mark UIScrollView Delegate

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
  return  self.imageView;
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
  
  CGRect frame = self.imageView.frame;
  
  frame.origin.y = (self.scrollView.frame.size.height - self.imageView.frame.size.height) > 0 ? (self.scrollView.frame.size.height - self.imageView.frame.size.height) * 0.5 : 0;
  frame.origin.x = (self.scrollView.frame.size.width - self.imageView.frame.size.width) > 0 ? (self.scrollView.frame.size.width - self.imageView.frame.size.width) * 0.5 : 0;
  self.imageView.frame = frame;
  
  self.scrollView.contentSize = CGSizeMake(self.imageView.frame.size.width + 30, self.imageView.frame.size.height + 30);
}



@end
