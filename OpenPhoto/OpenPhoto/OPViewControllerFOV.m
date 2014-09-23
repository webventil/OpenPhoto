//
//  OPViewControllerFOV.m
//  OpenPhoto
//
//  Created by Johannes Steudle on 23.09.14.
//  Copyright (c) 2014 JDSystems. All rights reserved.
//

#import "OPViewControllerFOV.h"
#import <math.h>

#define NUMBER_OF_COMPONENTS 1
#define HORIZONTAL_LENGTH 36
#define VERTICAL_LENGTH 24

@implementation OPViewControllerFOV

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.focalLengthPicker.delegate = self;
    self.focalLengthPicker.dataSource = self;

    self.focalLengths = [NSArray arrayWithObjects:@24, @35, @50, @60, @70, nil];

    double horizontalAngle = [self calculateAngle:36 withFocalLength:50];
    double verticalAngle = [self calculateAngle:24 withFocalLength:50];

    [self.fieldHorizontalAngle setText:[NSString stringWithFormat:@"%.2f", horizontalAngle]];
    [self.fieldVerticalAngle setText:[NSString stringWithFormat:@"%.2f", verticalAngle]];
    [self.fieldDiagonalAngle setText:@"0.0"];
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
    long focalLength = [[self.focalLengths objectAtIndex:focalLengthDataIndex] integerValue];

    double horizontalAngle = [self calculateAngle:HORIZONTAL_LENGTH withFocalLength:focalLength];
    double verticalAngle = [self calculateAngle:VERTICAL_LENGTH withFocalLength:focalLength];

    double diagonalLength = sqrt(pow(HORIZONTAL_LENGTH, 2) + pow(VERTICAL_LENGTH, 2));

    double diagonalAngle = [self calculateAngle:diagonalLength withFocalLength:focalLength];

    [self.fieldHorizontalAngle setText:[NSString stringWithFormat:@"%.2f", horizontalAngle]];
    [self.fieldVerticalAngle setText:[NSString stringWithFormat:@"%.2f", verticalAngle]];
    [self.fieldDiagonalAngle setText:[NSString stringWithFormat:@"%.2f", diagonalAngle]];
}

- (double)calculateAngle:(int)length withFocalLength:(double)focalLength
{
    double angleSize = 2 * atan(length / (2 * focalLength));
    return 57.3 * angleSize;
}

@end
