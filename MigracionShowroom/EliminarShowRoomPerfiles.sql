ALTER procedure [ShowRoom].[EliminarShowRoomPerfiles]
@EventoID int
as
begin
delete from ShowRoom.Perfil where EventoID = @EventoID
end