//
//  ListaRoles.h
//  Projeto03
//
//  Created by ARTHUR HENRIQUE VIEIRA DE OLIVEIRA on 11/03/14.
//  Copyright (c) 2014 ARTHUR HENRIQUE VIEIRA DE OLIVEIRA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Role.h"
#import "Usuario.h"
#import "ListaRolesDelegate.h"

@interface ListaRoles : NSObject
{
    NSMutableArray *listaDeUsuarios;
    NSMutableArray *listaDeRoles;
    NSMutableArray *listaDeDelegates;
    int _idUsuarios;
    int _idRoles;
}

@property CLGeocoder *geocoder;

+ (ListaRoles *) lista;

// Gerenciamento de Usuários
- (int)adicionarUsuario:(NSString*)nome avatar:(UIImage*)avatar;
- (bool)removerUsuario:(int)idUsuario;
- (Usuario*)getUsuarioPorId:(int)idUsuario;
- (int)atualizarUsuario:(Usuario*)usuario;

// Gerenciamento de Roles
- (int)adicionarRoleDo:(Usuario *)dono noEndereco:(NSString *)endereco comDescricao:(NSString *)descricao naData:(NSDate *)data comConvidados:(NSMutableArray *)convidados sendoPublico:(BOOL)publico;
- (bool)removerRole:(int)idRole;
- (Role*)getRolePorId:(int)idRole;
- (int)atualizarRole:(Role*)role;
- (NSArray *)rolesDistando:(double)metros doLocal:(CLLocationCoordinate2D)origem;
- (NSArray *)todosOsRoles;


// Gerenciamento de delegates
- (void)registrarDelegate:(id<ListaRolesDelegate>)delegate;
- (void)removerDelegate:(id<ListaRolesDelegate>)delegate;

@end