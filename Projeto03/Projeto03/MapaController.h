//
//  MapaController.h
//  Projeto03
//
//  Created by ARTHUR HENRIQUE VIEIRA DE OLIVEIRA on 10/03/14.
//  Copyright (c) 2014 ARTHUR HENRIQUE VIEIRA DE OLIVEIRA. All rights reserved.
//

#import "ViewController.h"

@interface MapaController : ViewController <MKMapViewDelegate, UITextFieldDelegate>
{
    CGPoint coordinates;
}

@property (strong, nonatomic) MKMapView *mapa;
@property (strong, nonatomic) UITextField *endereco;

@property (weak, nonatomic) IBOutlet UISegmentedControl *tiposMapa;

- (IBAction)mudarMapa:(id)sender;

@end
