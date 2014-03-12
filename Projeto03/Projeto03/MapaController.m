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
    }
    return self;
} 

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Inicializando o mapa e o colocando na view
    [self setMapa:[[MKMapView alloc] initWithFrame:CGRectMake(0, 30, 400, 600)]];
    [[self view] addSubview:[self mapa]];
    
    // Mostrando a localização do usuário
    [[self mapa] setShowsUserLocation:true];
    // Colocando o delegate no mapa
    [[self mapa] setDelegate:self];
    
    // Inicializando o endereço
    [self setEndereco:[[UITextField alloc] initWithFrame:CGRectMake(0, 65, 320, 30)]];
    [[self endereco] setBorderStyle:UITextBorderStyleRoundedRect];
    [[self endereco] setDelegate:self];
    [[self view] addSubview:[self endereco]];
    
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                         action:@selector(colocarPinch:)];
    tgr.numberOfTapsRequired = 1;
    [[self mapa] addGestureRecognizer:tgr];
    
    [self criarEventosHardCode];
}

- (void)colocarPinch:(UIGestureRecognizer *)gesture
{
    CGPoint point = [gesture locationInView:[self mapa]];
    CLLocationCoordinate2D locCoord = [[self mapa] convertPoint:point toCoordinateFromView:[self mapa]];
    MKPointAnnotation *ponto = [[MKPointAnnotation alloc] init];
    
    [ponto setCoordinate:locCoord];
    
    [[self mapa] addAnnotation:ponto];
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


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UIView *view in [[self view] subviews])
    {
        [view resignFirstResponder];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self marcarPosicaoNoMapa];
    
    return true;
}

- (void)criarEventosHardCode
{
    CLGeocoder *geo = [[CLGeocoder alloc] init];
    [geo geocodeAddressString:@"Av Engenheiro Eusébio Stevaux, 823, São Paulo, SP" completionHandler:^(NSArray *placemarks, NSError *error)
     {
         for (CLPlacemark *placemark in placemarks)
         {
             // Criando a localização
             CLLocationCoordinate2D local;
             // Criando o ponto
             MKPointAnnotation *ponto = [[MKPointAnnotation alloc] init];
             
             // Criando a latitude e a longitude
             NSString *_latitude = [NSString stringWithFormat:@"%f", [[placemark location] coordinate].latitude];
             NSString *_longitude = [NSString stringWithFormat:@"%f", [[placemark location] coordinate].longitude];
             local.latitude = [_latitude doubleValue];
             local.longitude = [_longitude doubleValue];
             
             ponto.coordinate = local;
             
             [ponto setTitle:@"Av Engenheiro Eusébio Stevaux, 823, São Paulo, SP"];
             
             [[self mapa] addAnnotation:ponto];
         }
     }];
    
    CLGeocoder *geo2 = [[CLGeocoder alloc] init];
    [geo2 geocodeAddressString:@"Rua Manuel FIgueiredo Landim, 600, São Paulo, SP" completionHandler:^(NSArray *placemarks, NSError *error)
     {
         for (CLPlacemark *placemark in placemarks)
         {
             // Criando a localização
             CLLocationCoordinate2D local;
             // Criando o ponto
             MKPointAnnotation *ponto = [[MKPointAnnotation alloc] init];
             
             // Criando a latitude e a longitude
             NSString *_latitude = [NSString stringWithFormat:@"%f", [[placemark location] coordinate].latitude];
             NSString *_longitude = [NSString stringWithFormat:@"%f", [[placemark location] coordinate].longitude];
             local.latitude = [_latitude doubleValue];
             local.longitude = [_longitude doubleValue];
             
             ponto.coordinate = local;
             
             [ponto setTitle:@"Rua Manuel FIgueiredo Landim, 600, São Paulo, SP"];
             
             [[self mapa] addAnnotation:ponto];
         }
     }];
}

// Metodo para marcar um novo ponto no mapa
- (void)marcarPosicaoNoMapa
{
    CLGeocoder *geo = [[CLGeocoder alloc] init];
    [geo geocodeAddressString:[[self endereco] text] completionHandler:^(NSArray *placemarks, NSError *error)
    {
        for (CLPlacemark *placemark in placemarks)
        {
            // Criando a localização
            CLLocationCoordinate2D local;
            // Criando o ponto
            MKPointAnnotation *ponto = [[MKPointAnnotation alloc] init];
            
            // Criando a latitude e a longitude
            NSString *_latitude = [NSString stringWithFormat:@"%f", [[placemark location] coordinate].latitude];
            NSString *_longitude = [NSString stringWithFormat:@"%f", [[placemark location] coordinate].longitude];
            local.latitude = [_latitude doubleValue];
            local.longitude = [_longitude doubleValue];
            
            // Zoom no ponto
            MKCoordinateRegion regiao;
            regiao.center = local;
            ponto.coordinate = local;
            
            // Define o titulo da marcação
            [ponto setTitle:[[self endereco] text]];
            
            // Adiciona o zoom e a marcação
            [[self mapa] setRegion:regiao];
            [[self mapa] addAnnotation:ponto];
            
            // Limpa o texto
            [[self endereco] setText:@""];
        }
    }];
}

// Metodo para escolher qual o estilo de mapa visualizado
- (IBAction)mudarMapa:(id)sender
{
    if ([sender selectedSegmentIndex] == 0)
    {
        [[self mapa] setMapType:MKMapTypeStandard];
    }
    else if ([sender selectedSegmentIndex] == 2)
    {
        [[self mapa] setMapType:MKMapTypeSatellite];
    }
    else if ([sender selectedSegmentIndex] == 1)
    {
        [[self mapa] setMapType:MKMapTypeHybrid];
    }
}
@end
