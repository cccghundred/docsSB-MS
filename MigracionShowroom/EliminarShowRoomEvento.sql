ALTER procedure [ShowRoom].[EliminarShowRoomEvento]
@EventoID int,
@CampaniaID int
as
begin
delete from ShowRoom.Evento
where EventoID = @EventoID and CampaniaID = @CampaniaID
end