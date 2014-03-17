//
//  CadastrarRoleControllerViewController.h
//  Projeto03
//
//  Created by Arthur Henrique Vieira de Oliveira on 11/03/14.
//  Copyright (c) 2014 ARTHUR HENRIQUE VIEIRA DE OLIVEIRA. All rights reserved.
//

#import "MenuPrincipalController.h"
#import "Role.h"

#define MODO_EDITAR_ROLE 0
#define MODO_EXIBIR_ROLE 1
#define MODO_CRIAR_ROLE 2

@interface CadastrarRoleControllerViewController : MenuPrincipalController
{
    Role *roleAEditar;
}

@property (weak, nonatomic) IBOutlet UIImageView *imagemAvatar;
@property (weak, nonatomic) IBOutlet UITextView *textoDescricao;
@property (weak, nonatomic) IBOutlet UIDatePicker *dataRole;
@property (weak, nonatomic) IBOutlet UITableView *tabelaConvidados;
@property (weak, nonatomic) IBOutlet UIView *containerDataRole;
@property (weak, nonatomic) IBOutlet UIButton *botaoData;

@property int modoAtual;
@property BOOL veioDeMapa;

- (void)editarRole:(Role*)role;
- (void)exibirRole:(Role*)role;
- (void)criarRole;

@end