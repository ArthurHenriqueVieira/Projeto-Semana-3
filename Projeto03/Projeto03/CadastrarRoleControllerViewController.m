//
//  CadastrarRoleControllerViewController.m
//  Projeto03
//
//  Created by Arthur Henrique Vieira de Oliveira on 11/03/14.
//  Copyright (c) 2014 ARTHUR HENRIQUE VIEIRA DE OLIVEIRA. All rights reserved.
//

#import "CadastrarRoleControllerViewController.h"
#import "MapaController.h"

@interface CadastrarRoleControllerViewController ()

@end

@implementation CadastrarRoleControllerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.imagemAvatar.layer.borderColor = 0;
    self.imagemAvatar.layer.borderWidth = 1;
    
    self.textoDescricao.layer.borderColor = 0;
    self.textoDescricao.layer.borderWidth = 1;
    
    self.containerDataRole.hidden = YES;
    
    // Atualiza a data
    [self atualizarData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier compare:@"escolherLocal"] == NSOrderedSame)
    {
        // Troca o modo do mapa para localização de roles
        [segue.destinationViewController setModoAtual:MODO_SELECIONAR_LOCAL];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UIView *view in [[self view] subviews])
    {
        [view resignFirstResponder];
    }
    
    UITouch *touch = [touches anyObject];
    
    if(touch.view != self.containerDataRole && touch.view != self.dataRole)
    {
        self.containerDataRole.hidden = YES;
        
        [self atualizarData];
    }
}

- (IBAction)botaoDataTap:(id)sender
{
    self.containerDataRole.hidden = !self.containerDataRole.hidden;
    
    if(self.containerDataRole.hidden == YES)
    {
        [self atualizarData];
    }
}

- (void)atualizarData
{
    [self.botaoData setTitle:[NSString stringWithFormat:@"%@", self.dataRole.date] forState:UIControlStateNormal];
}

- (void)exibirRole:(Role*)role
{
    [self.textoDescricao setText:role.descricao];
    [self.dataRole setDate:role.data];
    
    [self atualizarData];
    
    self.textoDescricao.editable = NO;
}

- (void)editarRole:(Role*)role
{
    roleAEditar = role;
    
    [self exibirRole:role];
    
    self.textoDescricao.editable = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end