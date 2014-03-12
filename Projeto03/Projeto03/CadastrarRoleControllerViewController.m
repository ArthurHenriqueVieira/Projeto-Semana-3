//
//  CadastrarRoleControllerViewController.m
//  Projeto03
//
//  Created by Arthur Henrique Vieira de Oliveira on 11/03/14.
//  Copyright (c) 2014 ARTHUR HENRIQUE VIEIRA DE OLIVEIRA. All rights reserved.
//

#import "CadastrarRoleControllerViewController.h"

@interface CadastrarRoleControllerViewController ()

@end

@implementation CadastrarRoleControllerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
    NSString *lbl = self.botaoData.titleLabel.text;
    
    [self.botaoData setTitle:[NSString stringWithFormat:@"%@", self.dataRole.date] forState:UIControlStateNormal];
}

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
