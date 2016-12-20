//
//  ASImageHistogram.m
//  ASImageCompare
//
//  Created by Alexey Subbotkin on 19/12/2016.
//  Copyright © 2016 Alexey Subbotkin. All rights reserved.
//

#import "ASImageHistogram.h"

@interface ASImageHistogram ()

@property (nonatomic, strong, readwrite) UIImage *image;

@property (nonatomic, assign, readwrite) struct ColorHistogram redHistogram;
@property (nonatomic, assign, readwrite) struct ColorHistogram greenHistogram;
@property (nonatomic, assign, readwrite) struct ColorHistogram blueHistogram;

@end

@implementation ASImageHistogram

#pragma mark - Init Methods

- (instancetype)initWithImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        _image = image;
    }
    
    return self;
}

#pragma mark - Public Methods

- (void)calculate
{
    CGSize imageSize = self.image.size;
    
    struct ColorHistogram redHistogram;
    struct ColorHistogram greenHistogram;
    struct ColorHistogram blueHistogram;
    
    [self initColorHistogram:&redHistogram];
    [self initColorHistogram:&greenHistogram];
    [self initColorHistogram:&blueHistogram];
    
    CFDataRef pixelData = CGDataProviderCopyData(CGImageGetDataProvider(self.image.CGImage));
    const UInt8 *data = CFDataGetBytePtr(pixelData);
    
    for (NSInteger i = 0; i < imageSize.width; i++) {
        for (NSInteger j = 0; j < imageSize.height; j++) {
            int pixelInfo = ((self.image.size.width * i) + j) * 4;
            
            UInt8 red = data[pixelInfo];
            UInt8 green = data[(pixelInfo + 1)]; 
            UInt8 blue = data[pixelInfo + 2];
            
            [self addColorValue:red toColorHistogram:&redHistogram];
            [self addColorValue:green toColorHistogram:&greenHistogram];
            [self addColorValue:blue toColorHistogram:&blueHistogram];
        }
    }
    
    CFRelease(pixelData);
    
    [self normilizeColorHistogram:&redHistogram withImageSize:imageSize];
    [self normilizeColorHistogram:&greenHistogram withImageSize:imageSize];
    [self normilizeColorHistogram:&blueHistogram withImageSize:imageSize];
    
    self.redHistogram = redHistogram;
    self.greenHistogram = greenHistogram;
    self.blueHistogram = blueHistogram;
}

#pragma mark - Private Methods

- (void)initColorHistogram:(struct ColorHistogram *)colorHistogram
{
    colorHistogram->bucket1 = 0;
    colorHistogram->bucket2 = 0;
    colorHistogram->bucket3 = 0;
    colorHistogram->bucket4 = 0;
}

- (void)addColorValue:(UInt8)colorValue toColorHistogram:(struct ColorHistogram *)colorHistogram
{
    if (colorValue >= 0 && colorValue <= 63) {
        colorHistogram->bucket1 += 1;
    } else if (colorValue >= 64 && colorValue <= 127) {
        colorHistogram->bucket2 += 1;
    } else if (colorValue >= 128 && colorValue <= 191) {
        colorHistogram->bucket3 += 1;
    } else if (colorValue >= 192 && colorValue <= 255) {
        colorHistogram->bucket4 += 1;
    }
}

- (void)normilizeColorHistogram:(struct ColorHistogram *)colorHistogram withImageSize:(CGSize)imageSize
{
    NSInteger totalPixelCount = imageSize.height * imageSize.width;
    
    colorHistogram->bucket1 /= totalPixelCount;
    colorHistogram->bucket2 /= totalPixelCount;
    colorHistogram->bucket3 /= totalPixelCount;
    colorHistogram->bucket4 /= totalPixelCount;
}

@end
