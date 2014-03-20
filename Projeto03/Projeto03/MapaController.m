//
//  MapaController.m
//  Projeto03
//
//  Created by ARTHUR HENRIQUE VIEIRA DE OLIVEIRA on 10/03/14.
//  Copyright (c) 2014 ARTHUR HENRIQUE VIEIRA DE OLIVEIRA. All rights reserved.
//

#import "MapaController.h"
#import "ListaRoles.h"
#import "CadastrarRoleControllerViewController.h"

@interface MapaController ()

@end

@implementation MapaController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"verInformacoes"])
    {
        CadastrarRoleControllerViewController *controller = segue.destinationViewController;
        
        controller.veioDeMapa = YES;
        [controller exibirRole:self.roleParaMostrar];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Inicializando o mapa e o colocando na view
    [self setMapa:[[MKMapView alloc] initWithFrame:CGRectMake(0, 90, self.view.frame.size.width, self.view.frame.size.height)]];
    [[self view] addSubview:[self mapa]];
    
    // Mostrando a localização do usuário
    [[self mapa] setShowsUserLocation:true];
    // Colocando o delegate no mapa
    [[self mapa] setDelegate:self];
    
    [self.mapa setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // Inicializando o endereço
    [self setEndereco:[[UITextField alloc] initWithFrame:CGRectMake(0, 65, 320, 30)]];
    [[self endereco] setBorderStyle:UITextBorderStyleRoundedRect];
    [[self endereco] setDelegate:self];
    [[self view] addSubview:[self endereco]];
    
    UIView *mapa = self.mapa;
    UIView *buscaBar = self.endereco;
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(mapa, buscaBar);
    
    NSArray *constraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[buscaBar]|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:viewsDictionary];
    
    [self.view addConstraints:constraint];
    
    NSLog(@"%lf x %lf   %lf x %lf", self.mapa.frame.origin.x, self.mapa.frame.origin.y, self.mapa.frame.size.width, self.mapa.frame.size.height);
    
    // Sem documentação
    self.adicionouRoles = NO;
    
    // Prepara a view dependendo do modo de manipulação de dados
    if(self.modoAtual == MODO_LOCALIZAR_ROLES)
    {
        // Adiciona essa classe como delegate para recebimento de eventos de mudanças de roles
        [[ListaRoles lista] registrarDelegate:self];
    }
    else if(self.modoAtual == MODO_SELECIONAR_LOCAL)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tip"
                                                        message:@"Hold on the Map to put the PIN!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        UILongPressGestureRecognizer *segurar = [[UILongPressGestureRecognizer alloc]
                                              initWithTarget:self action:@selector(colocarPinch:)];
        [segurar setMinimumPressDuration:1.0];  //tempo que tem que ficar com o dedo na tela
        [[self mapa] addGestureRecognizer:segurar];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    // Remove o delegate
    [[ListaRoles lista] removerDelegate:self];
}

- (void)colocarPinch:(UILongPressGestureRecognizer *)gesture
{
    if(gesture.state == UIGestureRecognizerStateBegan)
    {
        CGPoint point = [gesture locationInView:[self mapa]];
        CLLocationCoordinate2D locCoord = [[self mapa] convertPoint:point toCoordinateFromView:[self mapa]];
        MKPointAnnotation *ponto = [[MKPointAnnotation alloc] init];
        
        [ponto setCoordinate:locCoord];
        
        [[self mapa] addAnnotation:ponto];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [self searchAPI];
    
    if (![self achou])
    {
        [self marcarPosicaoNoMapa];
    }
    
    [[self mapa] removeAnnotations:[[self mapa] annotations]];
    
    [self atualizarEventosProximos];
    
    return true;
}

- (void)atualizarEventosProximos
{
    self.adicionouRoles = YES;
    
    // Remove os pins atuais
    [self.mapa removeAnnotations:self.mapa.annotations];
    
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
            
            // Criando a latitude e a longitude
            NSString *_latitude = [NSString stringWithFormat:@"%f", [[placemark location] coordinate].latitude];
            NSString *_longitude = [NSString stringWithFormat:@"%f", [[placemark location] coordinate].longitude];
            local.latitude = [_latitude doubleValue];
            local.longitude = [_longitude doubleValue];
            
            [self calcularRota:local];
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

// Métodos do delegate
- (void)listaRole:(ListaRoles *)lista atualizouEnderecoDe:(Role *)role
{
    [self atualizarEventosProximos];
}

// Centraliza o mapa no usuário
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    // Centraliza o mapa ao redor da posição atual do usuário
    [[self mapa] setCenterCoordinate:[[userLocation location] coordinate] animated:YES];
    
    // Dá um zoom na região atual do usuário
    self.mapa.region = MKCoordinateRegionMake(userLocation.location.coordinate, MKCoordinateSpanMake(0.1, 0.1));
    
    self.localizacaoAtual = userLocation.location.coordinate;
    
    [self atualizarEventosProximos];
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
    
    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"Role"];
    if(!annotationView)
    {
        if([annotation class] == [RoleAnnotation class])
        {
            annotationView = [[RoleAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Role"];
        }
        else
        {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Role"];
        }
        
        annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    }
    
    annotationView.canShowCallout = NO;
    annotationView.centerOffset = CGPointMake(1000, 1000);
    annotationView.enabled = YES;
    
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    if(![view.annotation isKindOfClass:[MKUserLocation class]])
    {
        /*
        CGSize  calloutSize = CGSizeMake(100.0, 80.0);
        UIView *calloutView = [[UIView alloc] initWithFrame:CGRectMake(0, calloutSize.height, calloutSize.width, calloutSize.height)];
        calloutView.backgroundColor = [UIColor whiteColor];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(5.0, 5.0, calloutSize.width - 10.0, calloutSize.height - 10.0);
        [button setTitle:@"OK" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(checkin) forControlEvents:UIControlEventTouchUpInside];
        [calloutView addSubview:button];
        [view.superview addSubview:calloutView];
        */
    }
    
    CGPoint point = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
    CLLocationCoordinate2D locCoord = [[self mapa] convertPoint:point toCoordinateFromView:[self mapa]];
    
    point = [self.mapa convertCoordinate:[view.annotation coordinate] toPointToView:self.mapa];
    
    CLLocationCoordinate2D locacao = self.mapa.centerCoordinate;
    
    [self.mapa setCenterCoordinate:[view.annotation coordinate]];
    
    CLLocationCoordinate2D coordenada = [self.mapa convertPoint:CGPointMake(self.mapa.frame.size.width / 2, self.mapa.frame.size.height / 1.21f) toCoordinateFromView:self.mapa];
    
//    [self.mapa setCenterCoordinate:coordenada];
    
    [self.mapa setCenterCoordinate:locacao];
    
    [self.mapa setCenterCoordinate:coordenada animated:YES];
    
    // Dá um zoom na região atual do usuário
    //self.mapa.region = MKCoordinateRegionMake([view.annotation coordinate], MKCoordinateSpanMake(0.1, 0.1));
    
    if([view class] == [RoleAnnotationView class])
    {
        [self criarViewAnotacao:view.annotation];
    }
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view
{
    if([view class] == [RoleAnnotationView class])
    {
        [self.viewAnotacao removeFromSuperview];
    }
}

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    [self.viewAnotacao removeFromSuperview];
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    RoleAnnotation *annotation = view.annotation;
    
    
    
    self.roleParaMostrar = annotation.role;
    
    [self performSegueWithIdentifier:@"verInformacoes" sender:self];
}

// Metodos para calcular a rota
- (void)calcularRota:(CLLocationCoordinate2D)destino
{
    if ([self inicio] == Nil)
    {
        MKPlacemark *placeInicio = [[MKPlacemark alloc] initWithCoordinate:[[[self mapa] userLocation] coordinate] addressDictionary:nil];
        
        [self setInicio:[[MKMapItem alloc] initWithPlacemark:placeInicio]];
        
        MKPlacemark *placeDestino = [[MKPlacemark alloc] initWithCoordinate:destino addressDictionary:Nil];
        
        [self setDestino:[[MKMapItem alloc] initWithPlacemark:placeDestino]];
        
        MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
        [request setSource:[self inicio]];
        [request setDestination:[self destino]];
        [request setRequestsAlternateRoutes:NO];
        
        MKDirections *direcoes = [[MKDirections alloc] initWithRequest:request];
        [direcoes calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error)
         {
             if (error)
             {
                 NSLog(@"Erro ao traçar caminho");
             }else
             {
                 [self mostraRota:response];
             }
         }];
    }
    if ([self inicio] != Nil && [self destino] != nil)
    {
        [self setInicio:nil];
        [self setDestino:nil];
        [[self mapa] removeOverlays:[[self mapa] overlays]];
    }
    
    [self.viewAnotacao removeFromSuperview];
    
    [[self mapa] removeAnnotations:[[self mapa] annotations]];
    
    [self atualizarEventosProximos];
    
    [[self endereco] setText:nil];
}

- (void)mostraRota:(MKDirectionsResponse *)response
{
    for (MKRoute *rota in response.routes)
    {
        [[self mapa] addOverlay:rota.polyline level:MKOverlayLevelAboveRoads];
        
        for (MKRouteStep *step in rota.steps)
        {
            NSLog(@"%@", step.instructions);
        }
    }
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    [self setRenderer:[[MKPolylineRenderer alloc] initWithOverlay:overlay]];
    [[self renderer] setStrokeColor:[UIColor blueColor]];
    [[self renderer] setLineWidth:5.0];
    
    return [self renderer];
}

- (void)criarViewAnotacao:(RoleAnnotation*)annotation
{
    CGPoint tamanho = CGPointMake(250, 300);
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(self.mapa.frame.size.width/2 - tamanho.x/2, (self.mapa.frame.size.height/2 - tamanho.y/2) + 40, tamanho.x, tamanho.y)];
    
    //view.backgroundColor = [UIColor whiteColor];
    view.backgroundColor = [UIColor whiteColor ];
    view.layer.cornerRadius = 10;
    view.layer.masksToBounds = YES;
    view.layer.borderColor = [UIColor colorWithRed:211.0/255.0 green:211.0/255.0 blue:211.0/255.0 alpha:1.0].CGColor;
    view.layer.borderWidth = 1.5f;
    
    NSString *stringEndereco = nil;
    
    UILabel *nomeEndereco = [[UILabel alloc] initWithFrame:CGRectMake(2, 2, view.frame.size.width, 20)];
    
    stringEndereco = [NSString stringWithFormat:@"%@", annotation.role.endereco._nome];
    nomeEndereco.text = stringEndereco;
    nomeEndereco.numberOfLines = 0;
    [nomeEndereco sizeToFit];
    [view addSubview:nomeEndereco];
    
    [[self endereco] setText:[[[annotation role] endereco] _nome]];
    
    UIButton *btnRota = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnRota setTitle:@"Calcular Rota" forState:UIControlStateNormal];
    [btnRota setFrame:CGRectMake(view.frame.size.width/2 - 50, view.frame.size.height - 20, 100, 20)];
    [btnRota addTarget:self action:@selector(marcarPosicaoNoMapa) forControlEvents:UIControlEventTouchDown];
    [view addSubview:btnRota];
    
    self.viewAnotacao = view;
    [[self view] addSubview:view];
}

-(void)searchAPI
{
    
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc]init];
    request.naturalLanguageQuery = self.endereco.text;
    /*self.textField.text*/
    request.region = self.mapa.region;
    
    self.matchItens = [[NSMutableArray alloc]init];
    
    MKLocalSearch *search = [[MKLocalSearch alloc]initWithRequest:request];
    
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        if (response.mapItems.count == 0) {
            NSLog(@"sem resultados");
            
            [self setAchou:NO];
        }
        
        else{
            for (MKMapItem *item in response.mapItems){
                
                [self.matchItens addObject:item];
                MKPointAnnotation *pointAnnotation = [[MKPointAnnotation alloc]init];
                pointAnnotation.coordinate = item.placemark.coordinate;
                pointAnnotation.title = item.name;
                [self.mapa addAnnotation:pointAnnotation];
                NSLog(@"%@",item.name);
                
                [self setAchou:YES];
            }
        }
    }];
}

@end


// RoleAnnotation
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


// RoleAnnotationView
@implementation RoleAnnotationView

@end