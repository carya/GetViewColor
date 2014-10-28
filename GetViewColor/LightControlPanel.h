//
//  LightControlPanel.h
//  Bulb
//
//  Created by MaohuaLiu on 14-9-30.
//  Copyright (c) 2014年 ghzy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ColorTempSlider;

@interface LightControlPanel : UIView <UIGestureRecognizerDelegate>

@property (nonatomic, strong) ColorTempSlider *cts;

- (void)renderColorTempSlider;
- (UIColor *)colorOfPoint:(CGPoint)point;


- (void)setColorTempSliderValueChangedBlock:(void(^)(UIColor *color))colorTempSliderValueChanged;
@end
