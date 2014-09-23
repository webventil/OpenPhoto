//
//  OPHelperFunctions.h
//  OpenPhoto
//
//  Created by Johannes Steudle on 23.09.14.
//  Copyright (c) 2014 JDSystems. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OPHelperFunctions : NSObject

+ (double)calculateHyperFocal:(long)focalLength
            withApertureValue:(double)apertureValue
      withCircleOfDistraction:(double)circleOfDistraction;

+ (double)calculateNearpoint:(long)distance
      withHyperFocalDistance:(double)hyperFocalDistance
            andApertureValue:(double)apertureValue;

+ (double)calculateFarPoint:(long)distance
     withHyperFocalDistance:(double)hyperFocalDistance
           andApertureValue:(double)apertureValue;
@end
