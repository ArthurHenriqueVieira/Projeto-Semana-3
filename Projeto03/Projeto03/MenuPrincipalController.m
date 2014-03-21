//
//  ViewController.m
//  Projeto03
//
//  Created by ARTHUR HENRIQUE VIEIRA DE OLIVEIRA on 10/03/14.
//  Copyright (c) 2014 ARTHUR HENRIQUE VIEIRA DE OLIVEIRA. All rights reserved.
//

#import "MenuPrincipalController.h"
#import "MapaController.h"
#import "CadastrarRoleControllerViewController.h"

@interface MenuPrincipalController ()

@end

@implementation MenuPrincipalController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"mapaDeRoles"])
    {
        // Troca o modo do mapa para localização de roles
        [segue.destinationViewController setModoAtual:MODO_LOCALIZAR_ROLES];
    }
    else if([segue.identifier isEqualToString:@"criarRole"])
    {
        [segue.destinationViewController criarRole];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end