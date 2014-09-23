//
//  OPViewControllerFOV.m
//  OpenPhoto
//
//  Created by Johannes Steudle on 23.09.14.
//  Copyright (c) 2014 JDSystems. All rights reserved.
//

#import "OPViewControllerFOV.h"
#import "OPHelperFunctions.h"
#import <math.h>

#define NUMBER_OF_COMPONENTS 1
#define HORIZONTAL_LENGTH 36
#define VERTICAL_LENGTH 24
#define MAX_FOCAL_LENGTH 200
#define MIN_FOCAL_LENGTH 14

@implementation OPViewControllerFOV

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.focalLengthPicker.delegate = self;
    self.focalLengthPicker.dataSource = self;

    self.focalLengths = [[NSMutableArray alloc] init];

    for (int i = MIN_FOCAL_LENGTH; i <= MAX_FOCAL_LENGTH; i++)
    {
        [self.focalLengths addObject:[NSNumber numberWithDouble:i]];
        if (i >= 30)
        {
            i += 4;
        }
    }

    [self.focalLengthPicker selectRow:0 inComponent:0 animated:false];
    [self calculateAndSet:0];
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
    return [self.focalLengths count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%@ mm", [self.focalLengths objectAtIndex:row]];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSInteger focalLengthDataIndex = [pickerView selectedRowInComponent:0];

    [self calculateAndSet:focalLengthDataIndex];
}

- (void)calculateAndSet:(NSInteger)focalLengthDataIndex
{
    long focalLength = [[self.focalLengths objectAtIndex:focalLengthDataIndex] integerValue];
    double horizontalAngle = [OPHelperFunctions calculateAngle:HORIZONTAL_LENGTH withFocalLength:focalLength];
    double verticalAngle = [OPHelperFunctions calculateAngle:VERTICAL_LENGTH withFocalLength:focalLength];

    double diagonalLength = sqrt(pow(HORIZONTAL_LENGTH, 2) + pow(VERTICAL_LENGTH, 2));
    double diagonalAngle = [OPHelperFunctions calculateAngle:diagonalLength withFocalLength:focalLength];

    [self.fieldHorizontalAngle setText:[NSString stringWithFormat:@"%.2f", horizontalAngle]];
    [self.fieldVerticalAngle setText:[NSString stringWithFormat:@"%.2f", verticalAngle]];
    [self.fieldDiagonalAngle setText:[NSString stringWithFormat:@"%.2f", diagonalAngle]];
}

@end
