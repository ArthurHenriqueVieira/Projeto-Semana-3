//
//  MapaController.h
//  Projeto03
//
//  Created by ARTHUR HENRIQUE VIEIRA DE OLIVEIRA on 10/03/14.
//  Copyright (c) 2014 ARTHUR HENRIQUE VIEIRA DE OLIVEIRA. All rights reserved.
//

#import "MenuPrincipalController.h"

#define MODO_LOCALIZAR_ROLES 0
#define MODO_SELECIONAR_LOCAL 1

@interface MapaController : UIViewController <MKMapViewDelegate, UITextFieldDelegate>
{
    CGPoint coordinates;
}

@property (strong, nonatomic) MKMapView *mapa;
@property (strong, nonatomic) UITextField *endereco;

@property bool adicionouRoles;
@property CLLocationCoordinate2D localizacaoAtual;
@property int modoAtual;

@property (weak, nonatomic) IBOutlet UISegmentedControl *tiposMapa;

- (IBAction)mudarMapa:(id)sender;

@end
