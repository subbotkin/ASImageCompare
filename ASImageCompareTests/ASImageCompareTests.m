//
//  ASImageCompareTests.m
//  ASImageCompareTests
//
//  Created by Alexey Subbotkin on 19/12/2016.
//  Copyright © 2016 Alexey Subbotkin. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIImage+Compare.h"

@interface ASImageCompareTests : XCTestCase

@end

@implementation ASImageCompareTests

- (void)setUp
{
    [super setUp];
    
}

- (void)tearDown
{
    
    [super tearDown];
}

- (void)testImageCompareSimilar
{
    UIImage *image1 = [UIImage imageNamed:@"test_image1" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    UIImage *image2 =[UIImage imageNamed:@"test_image2" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    
    CGFloat difference = [image1 differenceWithImage:image2];
    
    XCTAssert(difference < 1.3);
}

- (void)testImageCompareSame
{
    UIImage *image1 = [UIImage imageNamed:@"test_image1" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    UIImage *image2 =[UIImage imageNamed:@"test_image3" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    
    CGFloat difference = [image1 differenceWithImage:image2];
    
    XCTAssert(difference == 0);
}

- (void)testPerformanceExample
{
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
