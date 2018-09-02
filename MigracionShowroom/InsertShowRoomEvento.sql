ALTER procedure [ShowRoom].[InsertShowRoomEvento]
@EventoID int output,
@CampaniaID int,
@Nombre varchar(150),
@Tema varchar(150),
@DiasAntes int,
@DiasDespues int,
@NumeroPerfiles int,
@UsuarioCreacion varchar(20),
@TieneCategoria bit,
@TieneCompraXcompra bit,
@TieneSubCampania bit,
@TienePersonalizacion bit
as
begin
DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
insert into ShowRoom.Evento
(CampaniaID, Nombre, Tema, DiasAntes, DiasDespues, NumeroPerfiles, 
FechaCreacion, UsuarioCreacion, FechaModificacion, UsuarioModificacion, 
Estado, TieneCategoria, TieneCompraXcompra, TieneSubCampania, TienePersonalizacion)
values
(@CampaniaID, @Nombre, @Tema, @DiasAntes, @DiasDespues, @NumeroPerfiles,
@FechaGeneral, @UsuarioCreacion, @FechaGeneral, @UsuarioCreacion, 
1, @TieneCategoria, @TieneCompraXcompra, @TieneSubCampania, @TienePersonalizacion)
set @EventoID = @@IDENTITY
end