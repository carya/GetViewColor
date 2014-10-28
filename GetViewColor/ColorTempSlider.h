//
//  ColorTempSlider.h
//  Bulb
//
//  Created by MaohuaLiu on 14-9-30.
//  Copyright (c) 2014年 ghzy. All rights reserved.
//

#import "DrawCircus.h"

@interface ColorTempSlider : DrawCircus

@property (nonatomic, copy) void(^touchEventBeginBlock)(void);
@property (nonatomic, copy) void(^touchEventEndBlock)(void);

@property (nonatomic, copy) void(^valueChanged)(UIColor *currentColor);

- (id)initWithCenterPoint:(CGPoint)center
              innerRadius:(CGFloat)innerRadius
              outerRadius:(CGFloat)outerRadius
               startAngle:(CGFloat)startAngle
                 endAngle:(CGFloat)endAngle;

- (CAShapeLayer*)layer;

- (void)renderGradientLayer;
@end
