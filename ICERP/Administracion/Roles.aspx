<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" EnableEventValidation="false" AutoEventWireup="true" CodeBehind="Roles.aspx.cs" Inherits="ICERP.Administracion.Roles" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headContent" runat="server">
     <script type ="text/javascript">
         //$('#myModal').modal('show');
    </script>
     <script type="text/javascript">
         //function pageLoad() {
         //    LoadClasses();

         //};


         function validar() {
             var isStepValid = true;
             isStepValid = validarFormulario('valid');

             if (!isStepValid) {
                 $("input[validGroup = 'valid'], select[validGroup = 'valid']").each(function () {
                     var handler = function () {
                         $(this).validationEngine('validate');
                     };
                     $(this).unbind("change", handler);
                     $(this).change(handler);
                 });
                 $(this).validationEngine('hideAll');
                 $(this).validationEngine('validate');
                 return false;
             }
         };

         function validarFormulario(validGroupName) {
             var isValid = true;
             $("input[validGroup = " + validGroupName + "], select[validGroup = " + validGroupName + "]").each(function () {
                 var isInvaldField = $(this).validationEngine('validate');
                 if (isValid)
                     isValid = !isInvaldField;
             });
             return isValid;
         };

         $(document).ready(function () {
             $('#tblperfiles').DataTable({
                 "language": {
                     "zeroRecords": "No hay registros",
                     "info": "Mostrando (_START_ a _END_) de un total de _TOTAL_ ",
                     "infoEmpty": "Mostrando (0 a 0) de un total de 0",
                     "lengthMenu": "Mostrar _MENU_ Filas",
                     "infoFiltered": "(Filtrados de  _MAX_ Registros)",
                     "search": "Buscar:",
                     "paginate": {
                         "previous": "Anterior",
                         "next": "Siguiente"
                     }
                 }
             });
         });

         function actualizarperfiles(fila) {
             var tabl = document.getElementById('tblperfiles');
             var idx = fila.parentElement.parentElement.rowIndex;
             var id = tabl.rows[idx].cells[0].textContent.trim();
             $('#<%=hfPerfiles.ClientID %>').val(id);
             $("#<%=btnver.ClientID%>").click();
         };
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyContent" runat="server">
          <div>
 <asp:Button ID="btnver" runat="server" Text="Button" OnClick="abrir"  Style="display:none" />
        <asp:HiddenField ID="hfPerfiles" runat="server" />
    </div>

     <div class="box box-danger">
                <div class="box-header with-border">
                    <h3 class="box-title">Registro de Tipos de Consultorios</h3>
                </div>

    
                    
                    <div class="box-body">
    <table style="width:100%;">
        
        <tr>
            <td>
                <asp:Panel ID="panNuevaCaptura" runat="server">
                    <asp:Button ID="butNuevaCaptura" runat="server" CssClass="btn btn-info" Text="Nueva Captura" OnClick="butNuevaCaptura_Click" Visible="False" />
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Panel ID="panCaptura" runat="server">
                    <table style="width:100%;" class="table table-hover">
                        <tr>
                            <td class="auto-style3">Perfil de Usuario:</td>
                            <td class="auto-style4">
                                <asp:TextBox ID="texbRol" runat="server" CssClass="form-control validate[required,maxSize[100]] classNoHtml" Width="560px" ValidGroup="valid" MaxLength="100"  onkeypress="return event.keyCode!=13"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Activo:</td>
                            <td>
                                <asp:CheckBox ID="chebActivo" runat="server"  onkeypress="return event.keyCode!=13"/>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="text-align:right;">
                                <asp:Button ID="butGuardar" runat="server" CssClass="btn btn-success" OnClick="butGuardar_Click" Text="Guardar"  OnClientClick="return validar();"  />
                                <asp:Button ID="butActualizar" runat="server" CssClass="btn btn-success" OnClick="butActualizar_Click" Text="Actualizar"  OnClientClick="return validar();" />
                                <asp:Button ID="butCancelar" runat="server" CssClass="btn btn-warning" OnClick="butCancelar_Click" Text="Cancelar" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
     
    </table>

 <div align="center" style="width: 100%" >         
                <br />
                  <asp:Repeater ID="rptPerfiles" runat="server">
                    <HeaderTemplate>
                        <table id="tblperfiles" width="100%" style=" position:relative; height:200px; margin-top:10px; overflow:auto;" class="display"  bgcolor="#0066FF" >
                            <thead>
                                <tr>
                                     <th style="display:none" >
                                       RolId
                                    </th>
                                    <th >
                                       Rol
                                    </th>                                                                    
                                <th > Activo
                                    </th>
                                        <th > Editar
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>   <td  style="display:none">
                                <%# DataBinder.Eval(Container.DataItem, "ID")%>
                            </td>
                             <td >
                                <%# DataBinder.Eval(Container.DataItem, "NombreRol")%>
                            </td>  
                                   <td >
                                <asp:CheckBox ID="checkBoxActivo" Checked='<%#(bool)(DataBinder.Eval(Container.DataItem, "Activo"))%>'
                                            runat="server" Enabled="false"/>
                            </td>                       
                             <td style="width: 100px;">
                                <%--        <asp:ImageButton ID="btnActualizar" runat="server" ToolTip="Actualizar"
                                            AlternateText="Actualizar Periodo" ImageUrl="~/Images/1413317624_system-software-update.png" Width="20px"
                                           OnClientClick="addIdMatch(this); return true;" OnClick="actualizarperiodo"  Height="20px"/>--%>
                                 <a href="#myModal" role="button" class="btn btn-default" data-toggle="modal" onclick="actualizarperfiles(this);return true;"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span></a>
                                   </td>                                                   
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </tbody> </table>
                    </FooterTemplate>
                </asp:Repeater>
                <asp:HiddenField ID="hfid" runat="server" />                  
            </div>

                        </div>
       
         </div>
</asp:Content>
