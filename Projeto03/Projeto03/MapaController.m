//
//  MapaController.m
//  Projeto03
//
//  Created by ARTHUR HENRIQUE VIEIRA DE OLIVEIRA on 10/03/14.
//  Copyright (c) 2014 ARTHUR HENRIQUE VIEIRA DE OLIVEIRA. All rights reserved.
//

#import "MapaController.h"

@interface MapaController ()

@end

@implementation MapaController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [[self mapa] setShowsUserLocation:true];
        [[self mapa] setDelegate:self];
    }
    return self;
} 

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setMapa:[[MKMapView alloc] initWithFrame:CGRectMake(0, 30, 400, 600)]];
    [[self view] addSubview:[self mapa]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    [[self mapa] setCenterCoordinate:[[userLocation location] coordinate]];
}

- (IBAction)mudarMapa:(id)sender
{
    if ([sender selectedSegmentIndex] == 0)
    {
        [[self mapa] setMapType:MKMapTypeStandard];
    }else if ([sender selectedSegmentIndex] ==1 )
    {
        [[self mapa] setMapType:MKMapTypeSatellite];
    }else if ([sender selectedSegmentIndex] == 2)
    {
        [[self mapa] setMapType:MKMapTypeHybrid];
    }
}
@end
