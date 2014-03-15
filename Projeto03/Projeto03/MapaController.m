//
//  MapaController.m
//  Projeto03
//
//  Created by ARTHUR HENRIQUE VIEIRA DE OLIVEIRA on 10/03/14.
//  Copyright (c) 2014 ARTHUR HENRIQUE VIEIRA DE OLIVEIRA. All rights reserved.
//

#import "MapaController.h"
#import "ListaRoles.h"
#import "InfoDeRoleController.h"

@interface MapaController ()

@end

@implementation MapaController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    segue
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
    
    self.adicionouRoles = NO;
    
    // Prepara a view dependendo do modo de manipulação de dados
    if(self.modoAtual == MODO_LOCALIZAR_ROLES)
    {
        
    }
    else if(self.modoAtual == MODO_SELECIONAR_LOCAL)
    {
        UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                         action:@selector(colocarPinch:)];
        tgr.numberOfTapsRequired = 1;
        [[self mapa] addGestureRecognizer:tgr];
    }
    
    //[self adicionarEventosProximos];
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

// Centraliza o mapa no usuário
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    // Centraliza o mapa ao redor da posição atual do usuário
    [[self mapa] setCenterCoordinate:[[userLocation location] coordinate]];
    
    // Dá um zoom na região atual do usuário
    self.mapa.region = MKCoordinateRegionMake(userLocation.location.coordinate, MKCoordinateSpanMake(0.1, 0.1));
    
    self.localizacaoAtual = userLocation.location.coordinate;
    
    
    [self atualizarEventosProximos];
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

- (void)atualizarEventosProximos
{
    self.adicionouRoles = YES;
    
    // Pega os rolês próximos do usuário
    NSArray *roles = [[ListaRoles lista] rolesDistando:10000 doLocal:self.localizacaoAtual];
    
    for(Role *role in roles)
    {
        RoleAnnotation *ponto = [[RoleAnnotation alloc] initWithRole:role];
        
        ponto.coordinate = role.endereco._coord;
        [ponto setTitle:role.endereco._nome];
        
        [self.mapa addAnnotation:ponto];
    }
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


// Tentando pegar o Pin
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    // Caso o tipo de anotação seja um MKUserLocation, nil é retornado para que o controle
    // padrão seja criado
    if([annotation class] == [MKUserLocation class])
    {
        return nil;
    }
    
    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"String"];
    if(!annotationView)
    {
        annotationView = [[RoleAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"String"];
        annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
        NSLog(@"%@", annotation);
    }
    
    annotationView.enabled = YES;
    annotationView.canShowCallout = YES;
    
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    RoleAnnotation *annotation = view.annotation;
    
    [self performSegueWithIdentifier:@"verInformacoes" sender:self];
}

@end

@implementation RoleAnnotation

- (id)initWithRole:(Role*)role
{
    self = [super init];
    if (self)
    {
        self.role = role;
    }
    return self;
}

@end

@implementation RoleAnnotationView

@end
