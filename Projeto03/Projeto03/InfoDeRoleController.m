//
//  InfoDeRoleController.m
//  Projeto03
//
//  Created by Arthur Henrique Vieira de Oliveira on 11/03/14.
//  Copyright (c) 2014 ARTHUR HENRIQUE VIEIRA DE OLIVEIRA. All rights reserved.
//

#import "InfoDeRoleController.h"
#import "MapaController.h"

@interface InfoDeRoleController ()

@end

@implementation InfoDeRoleController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier compare:@"verNoMapa"] == NSOrderedSame)
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
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.imagemAvatar.layer.borderColor = 0;
    self.imagemAvatar.layer.borderWidth = 1;
    
    if(self.veioDeMapa)
    {
        [self.btnVerNoMapa setHidden:YES];
    }
    
    [self atualizarCampos];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)mostrarRole:(Role *)role
{
    self.roleAtual = role;
}

- (void)atualizarCampos
{
    [self.textoDescricao setText:self.roleAtual.descricao];
}

@end