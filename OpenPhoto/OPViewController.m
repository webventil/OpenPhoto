//
//  OPViewController.m
//  OpenPhoto
//
//  Created by Johannes Steudle on 11.09.14.
//  Copyright (c) 2014 JDSystems. All rights reserved.
//

#import "OPViewController.h"

@interface OPViewController ()

@end

@implementation OPViewController

@synthesize z;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataPicker.delegate = self;
    self.dataPicker.dataSource = self;
    self.focalLengths  = [[NSArray alloc] initWithObjects:@"24 mm", @"35 mm", @"50 mm", @"60 mm", @"70 mm", nil];
    self.apertureData = [[NSArray alloc] initWithObjects:@"1.4", @"1.8", @"2.0", @"2.8",@"4.0",@"5.6",@"6.3",@"8.0",@"16", @"18", @"20", @"22", nil];
    
    self.distanceData = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 100; i++)
    {
        [self.distanceData addObject:[NSString stringWithFormat:@"%d m", i + 1]];
    }
    
    self.z = [[NSNumber alloc] initWithDouble:0.03];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    if (component == 0)
    {
        return [self.focalLengths count];
    }
    else if (component == 1)
    {
        return [self.apertureData count];
    }
    else
    {
        return [self.distanceData count];
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row   forComponent:(NSInteger)component
{
    if (component == 0)
    {
        return [self.focalLengths objectAtIndex:row];
    }
    else if (component == 1)
    {
        return [self.apertureData objectAtIndex:row];
    }
    else
    {
        return [self.distanceData objectAtIndex:row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component
{
    NSInteger focalLengthDataIndex = [pickerView selectedRowInComponent:0];
    NSInteger apertureDataIndex = [pickerView selectedRowInComponent:1];
    NSInteger distanceDataIndex = [pickerView selectedRowInComponent:2];
    
    long focalLength = [[[self.focalLengths objectAtIndex:focalLengthDataIndex] substringWithRange:NSMakeRange(0, 2)] integerValue];
    double aperture = [[self.apertureData objectAtIndex:apertureDataIndex] doubleValue];
    long distance = [[[self.distanceData objectAtIndex:distanceDataIndex] substringWithRange:NSMakeRange(0, 2)] integerValue];
    
    double hyperFocalDistance = [self calculateHyperFocal:focalLength withApertureValue:aperture];
    double nearPointDistance = [self calculateNearpoint:distance withHyperFocalDistance:focalLength andApertureValue:aperture];
    
    
    self.focalLengthTextField.text = [NSString stringWithFormat:@"%.2f", hyperFocalDistance / 1000];
    self.nearPointTextField.text = [NSString stringWithFormat:@"%.2f", nearPointDistance];
}

- (double) calculateHyperFocal:(long) focalLength withApertureValue:(double) apertureValue
{
    double result = ((focalLength * focalLength) / (apertureValue * [self.z doubleValue]) + focalLength);

    NSLog(@"Using parameter focalLength: %ld", focalLength);
    NSLog(@"Using parameter aperture: %f", apertureValue);
    NSLog(@"Calculating hyperfocal distance: %f", result);
    return result;
}

- (double) calculateNearpoint:(long) distance withHyperFocalDistance:(double) hyperFocalDistance andApertureValue:(double) apertureValue
{
    double nearpoint = (distance * hyperFocalDistance - apertureValue) / (hyperFocalDistance - apertureValue) + (distance - apertureValue);
    return nearpoint;
}

@end
