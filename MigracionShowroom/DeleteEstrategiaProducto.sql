ALTER PROCEDURE [dbo].[DeleteEstrategiaProducto]
@EstrategiaID INT
,@CUV VARCHAR(6)
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET Activo = 0
		,UsuarioModificacion = @UsuarioModificacion
		,FechaModificacion = GETDATE()
	WHERE EstrategiaID = @EstrategiaID
		AND CUV = @CUV
END