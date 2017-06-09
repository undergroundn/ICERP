<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="TipoConsultorios.aspx.cs" Inherits="ICERP.Catalogos.TipoConsultorios" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
     
        $(document).ready(function () {
            $('#example1').DataTable({
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
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <section class="content">
        <div class="row">
            <div class="box box-danger">
                <div class="box-header with-border">
                    <h3 class="box-title">Registro de Tipos de Consultorios</h3>
                </div>
                <!-- /.box-header -->
                <div class="box-body">
                    <div class="form-group">
                        <label for="nombre">Nombre</label>
                        <input type="text" class="form-control" id="nombre" placeholder="Nombre del tipo de sonsultorio">
                    </div>                
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" class="flat-red" checked>
                            Activo                 
                        </label>
                    </div>
                </div>
                <!-- /.box-body -->

                <div class="box-footer">
                    <div class="col-md-1">
                        <button type="submit" class="btn btn-success">Registrar</button>
                    </div>
                    <div class="col-md-1">
                        <button type="button" class="btn btn-warning">Cancelar</button>
                    </div>

                </div>
            </div>
              <div class="box">
            <div class="box-header">
              <h3 class="box-title">Tipos de Consultorios</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
                <div class="dataTables_wrapper form-inline dt-bootstrap">
   <div align="center" style="width: 100%" >         
                <br />
                  <asp:Repeater ID="rptPerfiles" runat="server">
                    <HeaderTemplate>
                        <table id="example1" width="100%" style=" position:relative; height:200px; margin-top:10px; overflow:auto;" class="display"  bgcolor="#0066FF" >
                            <thead>
                                <tr>
                                     <th style="display:none" >
                                       Id
                                    </th>
                                    <th>Nombre</th>                                                                              
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
                                <%# DataBinder.Eval(Container.DataItem, "Tipo")%>
                            </td>  
                              
                                   <td >
                                <asp:CheckBox ID="checkBoxActivo" Checked='<%#(bool)(DataBinder.Eval(Container.DataItem, "Activo"))%>'
                                            runat="server" Enabled="false"/>
                            </td>                       
                             <td style="width: 100px;">
                                <%--        <asp:ImageButton ID="btnActualizar" runat="server" ToolTip="Actualizar"
                                            AlternateText="Actualizar Periodo" ImageUrl="~/Images/1413317624_system-software-update.png" Width="20px"
                                           OnClientClick="addIdMatch(this); return true;" OnClick="actualizarperiodo"  Height="20px"/>--%>
                                 <a href="#myModal" role="button" class="btn btn-default" data-toggle="modal" ><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span></a>
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
            <!-- /.box-body -->
          </div>
        </div>
    </section>
</asp:Content>
