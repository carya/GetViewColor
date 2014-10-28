//
//  DrawCircus.h
//  Bulb
//
//  Created by MaohuaLiu on 14-9-30.
//  Copyright (c) 2014年 ghzy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawCircus : UIView

- (id)initWithCenterPoint:(CGPoint)center
              innerRadius:(CGFloat)innerRadius
              outerRadius:(CGFloat)outerRadius
               startAngle:(CGFloat)startAngle
                 endAngle:(CGFloat)endAngle;
- (CAShapeLayer*)layer;

@end
