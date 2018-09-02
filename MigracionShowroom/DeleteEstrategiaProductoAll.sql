ALTER PROCEDURE [dbo].[DeleteEstrategiaProductoAll] 
	 @EstrategiaID INT
	,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET Activo = 0
		,UsuarioModificacion = @UsuarioModificacion
		,FechaModificacion = getdate()
	WHERE EstrategiaID = @EstrategiaID
END