//
//  UIImage+Compare.h
//  ASImageCompare
//
//  Created by Alexey Subbotkin on 19/12/2016.
//  Copyright © 2016 Alexey Subbotkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Compare)

- (CGFloat)differenceWithImage:(UIImage *)otherImage;

@end
