ALTER procedure [ShowRoom].[DeshabilitarShowRoomEvento]
@EventoID int,
@CampaniaID int,
@UsuarioModificacion varchar(20)
as
begin
update ShowRoom.Evento set Estado = 0, UsuarioModificacion = @UsuarioModificacion
where EventoID = @EventoID and CampaniaID = @CampaniaID
end