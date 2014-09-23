//
//  OPHelperFunctions.m
//  OpenPhoto
//
//  Created by Johannes Steudle on 23.09.14.
//  Copyright (c) 2014 JDSystems. All rights reserved.
//

#import "OPHelperFunctions.h"

@implementation OPHelperFunctions

+ (double)calculateHyperFocal:(long)focalLength
            withApertureValue:(double)apertureValue
      withCircleOfDistraction:(double)circleOfDistraction
{
    return ((focalLength * focalLength) / (apertureValue * circleOfDistraction)) + focalLength;
}

+ (double)calculateNearpoint:(long)distance
      withHyperFocalDistance:(double)hyperFocalDistance
            andApertureValue:(double)apertureValue
{
    return (hyperFocalDistance * distance) / (hyperFocalDistance + distance);
}

+ (double)calculateFarPoint:(long)distance
     withHyperFocalDistance:(double)hyperFocalDistance
           andApertureValue:(double)apertureValue
{
    if (distance > hyperFocalDistance)
    {
        return MAXFLOAT;
    }
    else
    {
        return (distance * (hyperFocalDistance - apertureValue)) / (hyperFocalDistance - distance);
    }
}

@end
