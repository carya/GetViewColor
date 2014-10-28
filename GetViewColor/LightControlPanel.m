//
//  LightControlPanel.m
//  Bulb
//
//  Created by MaohuaLiu on 14-9-30.
//  Copyright (c) 2014年 ghzy. All rights reserved.
//

#import "LightControlPanel.h"
#import "ColorTempSlider.h"

#define kCircusWidth   50


@interface LightControlPanel ()

@property (nonatomic) CGPoint centerPoint;
@property (nonatomic) CGPoint beginTouchPoint;



@end

@implementation LightControlPanel


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self renderColorTempSlider];
    }
    
    return self;
}

- (void)renderColorTempSlider
{
    CGRect boundsRect = self.frame;
    CGPoint centerPoint = CGPointMake(CGRectGetMidX(boundsRect), CGRectGetMidY(boundsRect));
    CGFloat outerRadius = CGRectGetWidth(boundsRect)/2;
    _cts = [[ColorTempSlider alloc] initWithCenterPoint:centerPoint innerRadius:(outerRadius-kCircusWidth) outerRadius:outerRadius startAngle:90 endAngle:450];
    CGRect ctsFrame = _cts.frame;
    ctsFrame.origin.x = ctsFrame.origin.x - self.frame.origin.x;
    ctsFrame.origin.y = ctsFrame.origin.y - self.frame.origin.y;
    _cts.frame = ctsFrame;
    
    [self addSubview:_cts];
    
    __weak LightControlPanel *weakSelf = self;
    _cts.valueChanged = ^ (UIColor *color) {
        CGPoint point = CGPointMake(CGRectGetWidth(weakSelf.bounds)/2, 42);
        UIColor *colorOfPoint = [weakSelf colorOfPoint:point];
        weakSelf.superview.backgroundColor = colorOfPoint;
    };
    
    UIImageView *indicator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_color_temp_slider_indicator"]];
    CGRect indicatorFrame = indicator.frame;
    indicatorFrame.origin.x = (CGRectGetWidth(self.frame)-CGRectGetWidth(indicator.frame))/2;
    indicatorFrame.origin.y = 0;
    indicator.frame = indicatorFrame;
    [self addSubview:indicator];
}


- (UIColor *)colorOfPoint:(CGPoint)point
{
    unsigned char pixel[4] = {0};
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, kCGBitmapAlphaInfoMask & kCGImageAlphaPremultipliedLast);
    
    CGContextTranslateCTM(context, -point.x, -point.y);
    
    [self.layer renderInContext:context];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    NSLog(@"pixel: %d %d %d %d", pixel[0], pixel[1], pixel[2], pixel[3]);
    
    UIColor *color = [UIColor colorWithRed:pixel[0]/255.0 green:pixel[1]/255.0 blue:pixel[2]/255.0 alpha:pixel[3]/255.0];
    
    return color;
}


- (void)setColorTempSliderValueChangedBlock:(void (^)(UIColor *))colorTempSliderValueChanged
{
    _cts.valueChanged = colorTempSliderValueChanged;
}

@end
