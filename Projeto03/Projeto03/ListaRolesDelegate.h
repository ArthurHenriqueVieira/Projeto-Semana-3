//
//  ListaRolesDelegate.h
//  Projeto03
//
//  Created by Luiz Fernando Silva on 16/03/14.
//  Copyright (c) 2014 ARTHUR HENRIQUE VIEIRA DE OLIVEIRA. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ListaRoles;
@class Role;
// Delegate que recebe eventos da classe ListaRoles
@protocol ListaRolesDelegate <NSObject>

@optional

- (void)listaRole:(ListaRoles*)lista atualizouEnderecoDe:(Role*)role;
- (void)listaRole:(ListaRoles*)lista adicionouRole:(Role*)role;

@end