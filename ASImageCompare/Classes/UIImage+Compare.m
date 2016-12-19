//
//  UIImage+Compare.m
//  ASImageCompare
//
//  Created by Alexey Subbotkin on 19/12/2016.
//  Copyright © 2016 Alexey Subbotkin. All rights reserved.
//

#import "UIImage+Compare.h"
#import "ASImageHistogram.h"

@implementation UIImage (Compare)

- (CGFloat)differenceWithImage:(UIImage *)otherImage
{
    ASImageHistogram *currentImageHistogram = [[ASImageHistogram alloc] initWithImage:self];
    ASImageHistogram *otherImageHistogram = [[ASImageHistogram alloc] initWithImage:otherImage];
    
    [currentImageHistogram calculate];
    [otherImageHistogram calculate];
    
    CGFloat difference = 0;
    difference += [self differenceBetweenHistogram:currentImageHistogram.redHistogram andOtherHistogram:otherImageHistogram.redHistogram];
    difference += [self differenceBetweenHistogram:currentImageHistogram.greenHistogram andOtherHistogram:otherImageHistogram.greenHistogram];
    difference += [self differenceBetweenHistogram:currentImageHistogram.blueHistogram andOtherHistogram:otherImageHistogram.blueHistogram];
    
    return difference;
}

- (CGFloat)differenceBetweenHistogram:(struct ColorHistogram)colorHistogram andOtherHistogram:(struct ColorHistogram)otherHistogram
{
    CGFloat difference = 0;
    difference += ABS(colorHistogram.bucket1 - otherHistogram.bucket1);
    difference += ABS(colorHistogram.bucket2 - otherHistogram.bucket2);
    difference += ABS(colorHistogram.bucket3 - otherHistogram.bucket3);
    difference += ABS(colorHistogram.bucket4 - otherHistogram.bucket4);
    
    return difference;
}

@end
