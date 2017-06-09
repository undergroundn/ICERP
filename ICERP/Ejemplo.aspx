<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Ejemplo.aspx.cs" Inherits="ICERP.Ejemplo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    
    <script
  src="http://code.jquery.com/jquery-2.2.0.js"
  integrity="sha256-oYqpLeqZe9cetUDV+TFiBZHp3uJ+X4F5eLs4W6uSTSE="
  crossorigin="anonymous"></script>

    <script type="text/javascript">
        
        $(document).ready(function () {

            //ICERP_Core.llamarAjax("Consultorios.aspx/obtenerConsultorios", null);

            $.ajax({
                type: "POST",
                url: "Ejemplo/obtenerConsultorios",
                data: "{ 'idGrupoEvidencia': 1}",
                contentType: "application/json; charset=utf-8",
                
                success: function (data, textStatus, jqXHR) {
                    alert(data.d);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert(textStatus);
                }
            });

        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="smgPrincipal" runat="server" EnablePageMethods="True"></asp:ScriptManager>
        <div>
        </div>
    </form>
</body>
</html>
