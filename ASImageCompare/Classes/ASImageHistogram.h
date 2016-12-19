//
//  ASImageHistogram.h
//  ASImageCompare
//
//  Created by Alexey Subbotkin on 19/12/2016.
//  Copyright © 2016 Alexey Subbotkin. All rights reserved.
//

#import <UIKit/UIKit.h>

struct ColorHistogram {
    CGFloat bucket1; // 0-63
    CGFloat bucket2; // 64-127
    CGFloat bucket3; // 128-191
    CGFloat bucket4; // 192-255
};

@interface ASImageHistogram : NSObject

@property (nonatomic, assign, readonly) struct ColorHistogram redHistogram;
@property (nonatomic, assign, readonly) struct ColorHistogram greenHistogram;
@property (nonatomic, assign, readonly) struct ColorHistogram blueHistogram;

- (instancetype)initWithImage:(UIImage *)image;

- (void)calculate;

@end
