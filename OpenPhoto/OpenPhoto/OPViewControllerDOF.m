//
//  OPViewController.m
//  OpenPhoto
//
//  Created by Johannes Steudle on 11.09.14.
//  Copyright (c) 2014 JDSystems. All rights reserved.
//

#import "OPViewControllerDOF.h"
#import "OPHelperFunctions.h"
#import <math.h>

#define NUMBER_OF_COMPONENTS 3
#define FACTOR_M_TO_MM 1000
#define COUNT_OF_DISTANCE_VALUES 200
#define COUNT_OF_APERTURE_VALUES 10
#define MAX_FOCAL_LENGTH 200
#define MIN_FOCAL_LENGTH 14

@interface OPViewControllerDOF ()

@end

@implementation OPViewControllerDOF

@synthesize z;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.focalLengthsPicker.delegate = self;
    self.focalLengthsPicker.dataSource = self;

    self.focalLengths = [[NSMutableArray alloc] init];
    self.fNumberArray = [[NSMutableArray alloc] init];
    self.distanceData = [[NSMutableArray alloc] init];

    for (int i = MIN_FOCAL_LENGTH; i <= MAX_FOCAL_LENGTH; i++)
    {
        [self.focalLengths addObject:[NSNumber numberWithDouble:i]];
        if (i >= 30)
        {
            i += 4;
        }
    }

    for (int i = 0; i <= COUNT_OF_APERTURE_VALUES; i++)
    {
        double fNumber = sqrt(pow(2, i));
        [self.fNumberArray addObject:[NSNumber numberWithDouble:fNumber]];
    }

    for (int i = 1; i < COUNT_OF_DISTANCE_VALUES; i++)
    {
        [self.distanceData addObject:[NSNumber numberWithInt:i]];
        if (i >= 30)
        {
            i += 4;
        }
    }

    // Circle of confusion for 35mm sensor
    self.z = 0.03;

    [self.focalLengthsPicker selectRow:0 inComponent:0 animated:false];
    [self.focalLengthsPicker selectRow:0 inComponent:1 animated:false];
    [self.focalLengthsPicker selectRow:0 inComponent:2 animated:false];
    [self calculateAndSetValues:0 apertureDataIndex:0 distanceDataIndex:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)textFieldReturn:(id)sender { [sender resignFirstResponder]; }

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView { return NUMBER_OF_COMPONENTS; }

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)
    {
        return [self.focalLengths count];
    }
    else if (component == 1)
    {
        return [self.fNumberArray count];
    }
    else if (component == 2)
    {
        return [self.distanceData count];
    }
    return -1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0)
    {
        return [NSString stringWithFormat:@"%@ mm", [self.focalLengths objectAtIndex:row]];
    }
    else if (component == 1)
    {
        return [NSString stringWithFormat:@"f/%.1f", [[self.fNumberArray objectAtIndex:row] doubleValue]];
    }
    else
    {
        return [NSString stringWithFormat:@"%@ m", [self.distanceData objectAtIndex:row]];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSInteger focalLengthDataIndex = [pickerView selectedRowInComponent:0];
    NSInteger apertureDataIndex = [pickerView selectedRowInComponent:1];
    NSInteger distanceDataIndex = [pickerView selectedRowInComponent:2];

    [self calculateAndSetValues:focalLengthDataIndex
              apertureDataIndex:apertureDataIndex
              distanceDataIndex:distanceDataIndex];
}

- (void)calculateAndSetValues:(NSInteger)focalLengthDataIndex
            apertureDataIndex:(NSInteger)apertureDataIndex
            distanceDataIndex:(NSInteger)distanceDataIndex
{
    long focalLength = [[self.focalLengths objectAtIndex:focalLengthDataIndex] integerValue];
    double aperture = [[self.fNumberArray objectAtIndex:apertureDataIndex] doubleValue];
    long distance = [[self.distanceData objectAtIndex:distanceDataIndex] integerValue] * FACTOR_M_TO_MM;

    NSLog(@"Focal length: %ld", focalLength);
    NSLog(@"Aperture: %.2f", aperture);
    NSLog(@"Distance: %ld", distance);

    // in millimeter
    double hyperFocalDistance =
        [OPHelperFunctions calculateHyperFocal:focalLength withApertureValue:aperture withCircleOfDistraction:self.z];
    // in millimeter
    double nearPointDistance = [OPHelperFunctions calculateNearpoint:distance
                                              withHyperFocalDistance:hyperFocalDistance
                                                    andApertureValue:aperture];
    // in millimeter
    double farPointDistance = [OPHelperFunctions calculateFarPoint:distance
                                            withHyperFocalDistance:hyperFocalDistance
                                                  andApertureValue:aperture];

    self.focalLengthTextField.text = [NSString stringWithFormat:@"%.2f m", hyperFocalDistance / FACTOR_M_TO_MM];
    self.nearPointTextField.text = [NSString stringWithFormat:@"%.2f m", nearPointDistance / FACTOR_M_TO_MM];

    if (farPointDistance >= MAXFLOAT)
    {
        self.farPointTextField.text = @"\u221E";
        self.depthOfFieldTextField.text = @"\u221E";
    }
    else
    {
        self.farPointTextField.text = [NSString stringWithFormat:@"%.2f m", farPointDistance / FACTOR_M_TO_MM];
        self.depthOfFieldTextField.text =
            [NSString stringWithFormat:@"%.2f m", (farPointDistance - nearPointDistance) / FACTOR_M_TO_MM];
    }
}

@end
