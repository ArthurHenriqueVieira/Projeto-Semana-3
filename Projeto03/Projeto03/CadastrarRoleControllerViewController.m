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
    
    if(roleAtual != nil)
    {
        [self exibirRole:roleAtual];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier compare:@"escolherLocal"] == NSOrderedSame)
    {
        if(self.modoAtual == MODO_CRIAR_ROLE || self.modoAtual == MODO_EDITAR_ROLE)
        {
            // Troca o modo do mapa para localização de roles
            [segue.destinationViewController setModoAtual:MODO_SELECIONAR_LOCAL];
            [segue.destinationViewController setDescricaoDoRole:self.textoDescricao.text];
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UIView *view in [[self view] subviews])
    {
        [view resignFirstResponder];
    }
    
    [self.textoDescricao resignFirstResponder];
    
    UITouch *touch = [touches anyObject];
    
    if(touch.view != self.containerDataRole && touch.view != self.dataRole)
    {
        [self atualizarData];
    }
}

- (IBAction)botaoDataTap:(id)sender
{
    [self mostrarEsconderDatePicker];
    
    if(self.containerDataRole.hidden == YES)
    {
        [self atualizarData];
    }
}

- (void)mostrarEsconderDatePicker
{
    if(self.containerDataRole.hidden)
    {
        [self mostrarDatePicker];
    }
    else
    {
        [self esconderDatePicker];
    }
}

- (void)mostrarDatePicker
{
    self.containerDataRole.hidden = NO;
    self.containerDataRole.userInteractionEnabled = YES;
}

- (void)esconderDatePicker
{
    self.containerDataRole.hidden = YES;
    self.containerDataRole.userInteractionEnabled = NO;
}

- (void)atualizarData
{
    [self.botaoData setTitle:[NSString stringWithFormat:@"%@", self.dataRole.date] forState:UIControlStateNormal];
}

- (void)exibirRole:(Role*)role
{
    roleAtual = role;
    
    [self.textoDescricao setText:role.descricao];
    [self.dataRole setDate:role.data];
    
    [self atualizarData];
    
    [self.botaoVerLocal setTitle:@"Ver Local no Mapa >" forState:UIControlStateNormal];
    self.textoDescricao.editable = NO;
    self.modoAtual = MODO_EXIBIR_ROLE;
}

- (void)editarRole:(Role*)role
{
    roleAtual = role;
    
    [self exibirRole:role];
    
    [self.botaoVerLocal setTitle:@"Escolher Local no Mapa >" forState:UIControlStateNormal];
    self.textoDescricao.editable = YES;
    self.modoAtual = MODO_EDITAR_ROLE;
}

- (void)criarRole
{
    roleAtual = nil;
    self.modoAtual = MODO_CRIAR_ROLE;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end