<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" EnableEventValidation="false" CodeBehind="Usuarios.aspx.cs" Inherits="ICERP.Administracion.Usuarios" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="<%=ResolveUrl("~/Scripts/jstree/jstree.min.js")%>"></script>
    <link href="<%=ResolveUrl("~/Styles/tree/style.min.css")%>" rel="stylesheet" />
    <script type="text/javascript">
        // var j = jQuery.noConflict();

        function pageLoad() {
            //$.unblockUI();
            $("#<%=btnguardar.ClientID%>").click(function (ev) {
                agregarusuario1();
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
                    return;
                }
                ev.preventDefault();
            });

            $("#<%=btnactualizar.ClientID%>").click(function (ev) {
                agregarusuario1();
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
                    return;
                }
                ev.preventDefault();
            });




        }
        function llenarDatosArbol() {
            var id = $("#<%=hfidusuario.ClientID%>").val();

            if (id == "")
            { id = "0"; }
            $.ajax({
                type: "POST",
                url: "Usuarios.aspx/llenararbol",
                data: '{id: ' + id + ' }',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var str = response.d;
                    cargararbol(str);
                },
                error: function (error) {
                    alert(error);
                }
            });

        }
        $(document).ready(function () {
            $('#tblusuarios').DataTable({
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
                },
                "responsive": true

            });
        });
        function desbloquear()
        { $.unblockUI(); };

        function cargararbol(datos) {
            var valores = JSON.parse(datos);

            $('#jstree_demo_div').jstree({
                'checkbox': {
                    "keep_selected_style": true
                },
                'plugins': ["checkbox", "wholerow"],
                'core': {
                    'data': valores
                }
            });

            if (document.getElementById("<%= btnguardar.ClientID%>").style.display == 'block') {
                            document.getElementById("<%= btnactualizar.ClientID%>").style.display = 'none';
                        }
                        else {
                            document.getElementById("<%= btnactualizar.ClientID%>").style.display = 'block';
                            document.getElementById("<%= btnguardar.ClientID%>").style.display = 'none';
                        }
                    }

                    function agregarusuario1() {

                        $('#<%=hfarbol.ClientID %>').val("");
            $('#<%=hfnodosseleccionados.ClientID %>').val("");
            var v = $("#jstree_demo_div").jstree(true).get_json('#', { 'flat': true });
            var datos = JSON.stringify(v);
            $('#<%=hfarbol.ClientID %>').val(datos);
                    var z = $('#jstree_demo_div').jstree(true).get_selected('full', true)
                    var datosz = JSON.stringify(z);
                    $('#<%=hfnodosseleccionados.ClientID %>').val(datosz);
        }



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
                $(this).validationEngine('validate');
            });
            return isValid;
        };
        function agregarusuario() {
            llenarDatosArbol();
            document.getElementById("<%= texbNombre.ClientID %>").value = "";
            document.getElementById("<%= texbPaterno.ClientID %>").value = "";
            document.getElementById("<%= texbMaterno.ClientID %>").value = "";
            document.getElementById("<%= texbClaveUsuario.ClientID %>").value = "";
            document.getElementById("<%= texbCorreo.ClientID %>").value = "";
            $("#<%=chebActivo.ClientID%>").attr("checked", true);
            $("#jstree_demo_div").jstree("deselect_all");
            $("#<%=hfidusuario.ClientID%>").val("");
                $('#Usuarios1').modal('show');
                document.getElementById("<%= btnguardar.ClientID%>").style.display = 'block';
                document.getElementById("<%= btnactualizar.ClientID%>").style.display = 'none';
        }

        function actualizarusuario(fila) {


            var tabl = document.getElementById('tblusuarios');
            var idx = fila.parentElement.parentElement.rowIndex;
            var id = tabl.rows[idx].cells[0].textContent.trim();
            var paterno = tabl.rows[idx].cells[1].textContent.trim();
            var materno = tabl.rows[idx].cells[2].textContent.trim();
            var nombre = tabl.rows[idx].cells[3].textContent.trim();
            var usuario = tabl.rows[idx].cells[4].textContent.trim();
            var correo = tabl.rows[idx].cells[5].textContent.trim();
            var rol = tabl.rows[idx].cells[6].textContent.trim();
            var activo = tabl.rows[idx].cells[7].textContent.trim();
            activo = activo.toLowerCase();

            $('#<%=hfidusuario.ClientID %>').val(id);
                document.getElementById("<%= texbNombre.ClientID %>").value = nombre;
                document.getElementById("<%= texbPaterno.ClientID %>").value = paterno;
                document.getElementById("<%= texbMaterno.ClientID %>").value = materno;
                document.getElementById("<%= texbClaveUsuario.ClientID %>").value = usuario;
                document.getElementById("<%= texbCorreo.ClientID %>").value = correo;
                document.getElementById("<%= ddlRol.ClientID %>").value = rol;
                if (activo == "true") {
                    $("#<%=chebActivo.ClientID%>").attr("checked", true);
                }
                if (activo == "false") {
                    $("#<%=chebActivo.ClientID%>").attr("checked", false);
            }

            llenarDatosArbol();
            agregarusuario1();

            $('#Usuarios1').modal('show');
            document.getElementById("<%= btnguardar.ClientID%>").style.display = 'none';
                document.getElementById("<%= btnactualizar.ClientID%>").style.display = 'block';

            };



            function seleccionartodo() {
                $("#jstree_demo_div").jstree("select_all");
            }

            function deseleccionartodo() { $("#jstree_demo_div").jstree("deselect_all"); }

            function cancelartodo() {
                document.getElementById("<%= texbNombre.ClientID %>").value = "";
                document.getElementById("<%= texbPaterno.ClientID %>").value = "";
                document.getElementById("<%= texbMaterno.ClientID %>").value = "";
                document.getElementById("<%= texbClaveUsuario.ClientID %>").value = "";
                document.getElementById("<%= texbCorreo.ClientID %>").value = "";
                $("#jstree_demo_div").jstree("deselect_all");
                $('#Usuarios1').modal('hide');

            }

            function checkuncheckall(prop) {
                var valor = prop.checked;

                if (valor == true) {
                    $("#jstree_demo_div").jstree("select_all");
                }
                else {
                    $("#jstree_demo_div").jstree("deselect_all");
                }

            }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="box box-danger">
        <div class="box-header with-border">
            <h3 class="box-title">Registro de Usuarios</h3>
        </div>
        <div class="box-body">
            <asp:Button ID="btnver" runat="server" Text="Button" OnClick="cargarrpt" Style="display: none" />
            <div class="modal fade" id="Usuarios1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog" style="width: 800px">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Cerrar</span></button>
                            <h4 class="modal-title" id="myModalLabel1">USUARIO </h4>
                        </div>
                        <div class="modal-body">

                            <table style="width: 100%;" id="tCaptura" class="table table-hover">
                                <tr>
                                    <td class="auto-style2">Nombre:</td>
                                    <td class="auto-style2">
                                        <asp:TextBox ID="texbNombre" runat="server" CssClass="form-control validate[required,maxSize[150]] classNoHtml" ValidGroup="valid" Width="500px" MaxLength="500" onkeypress="return event.keyCode!=13" Style="text-transform: uppercase;"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style2">Paterno:</td>
                                    <td class="auto-style2">
                                        <asp:TextBox ID="texbPaterno" runat="server" CssClass="form-control validate[required,maxSize[150]] classNoHtml" ValidGroup="valid" Width="500px" MaxLength="150" onkeypress="return event.keyCode!=13" Style="text-transform: uppercase;"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style2">Materno:</td>
                                    <td>
                                        <asp:TextBox ID="texbMaterno" runat="server" CssClass="form-control validate[required,maxSize[150]] classNoHtml" ValidGroup="valid" Width="500px" MaxLength="150" onkeypress="return event.keyCode!=13" Style="text-transform: uppercase;"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style2">Nombre de Usuario:</td>
                                    <td class="auto-style2">
                                        <asp:TextBox ID="texbClaveUsuario" runat="server" CssClass="form-control validate[required,maxSize[150]] classNoHtml" ValidGroup="valid" Width="500px" MaxLength="150" onkeypress="return event.keyCode!=13"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style2">Contraseña:</td>
                                    <td>
                                        <asp:TextBox ID="texbCorreo" runat="server" CssClass="form-control validate[required,custom[password],maxSize[250], classNoHtml" ValidGroup="valid" Width="500px" MaxLength="250" onkeypress="return event.keyCode!=13" TextMode="Password"></asp:TextBox>
                                    </td>

                                </tr>
                                <tr>
                                    <td class="auto-style2">Rol:</td>
                                    <td>
                                        <asp:DropDownList ID="ddlRol" runat="server" CssClass="form-control validate[required]" ValidGroup="valid" Width="500px">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Activo:</td>
                                    <td>
                                        <asp:CheckBox ID="chebActivo" runat="server" onkeypress="return event.keyCode!=13" />
                                    </td>
                                </tr>
                            </table>
                            <table>
                                <tr>

                                    <td></td>
                                </tr>

                            </table>
                            <button type="button" class="btn btn-success" onclick="seleccionartodo();" style="display: none;">CHECKALL</button>
                            <button type="button" class="btn btn-warning" onclick="deseleccionartodo();" style="display: none;">UNCHECKALL</button>
                            <input type="checkbox" name="option2" value="selectedall" id="selec" onclick="checkuncheckall(this);" onkeypress="return event.keyCode!=13" /><span>TODO</span>
                            <div id="jstree_demo_div">
                            </div>



                            <table style="width: 100%; text-align: right">
                                <tr>
                                    <td style="width: 70%; text-align: right;"></td>
                                    <td style="width: 15%; text-align: right;">

                                        <asp:Button ID="btnguardar" runat="server" Text="GUARDAR" CssClass="btn btn-success" OnClick="btnguardar_Click" OnClientClick="validar(); return false;" />
                                        <asp:Button ID="btnactualizar" runat="server" Text="ACTUALIZAR" CssClass="btn btn-success" OnClick="btnactualizar_Click" OnClientClick="validar(); return false;" />
                                    </td>
                                    <td style="width: 15%; text-align: right;">
                                        <asp:Button ID="btncancelar" runat="server" Text="CANCELAR" CssClass="btn btn-warning" OnClientClick="cancelartodo();" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>






                </div>

            </div>
            <br />
            <div align="left">
                <button type="button" class="btn btn-info" onclick="agregarusuario();">NUEVO</button>
            </div>
            <br />

            <div id="TablaUsuarios">
                <asp:Repeater ID="rptusuario" runat="server">
                    <HeaderTemplate>
                        <table id="tblusuarios" width="100%" style="position: relative; height: 200px; margin-top: 10px; overflow: auto;" class="display" bgcolor="#0066FF">
                            <thead>
                                <tr>
                                    <th style="display: none">usuarioId
                                    </th>
                                    <th>Apellido Paterno
                                    </th>
                                    <th>Apellido Materno
                                    </th>
                                    <th>Nombre
                                    </th>
                                    <th>Usuario
                                    </th>
                                    <th style="display: none">Contraseña
                                    </th>
                                    <th style="display: none">rolId
                                    </th>
                                    <th style="display: none">Activo
                                    </th>
                                    <th>Activo</th>
                                    <th>Editar
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td style="display: none">
                                <%# DataBinder.Eval(Container.DataItem, "ID")%>
                            </td>
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "ApPaterno")%>
                            </td>
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "ApMaterno")%>
                            </td>
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "Nombres")%>
                            </td>
                            <td>
                                <%# DataBinder.Eval(Container.DataItem, "NombreUsuario")%>
                            </td>
                            <td style="display: none">
                                <%# DataBinder.Eval(Container.DataItem, "Contraseña")%>
                            </td>
                            <td style="display: none">
                                <%# DataBinder.Eval(Container.DataItem, "RolId")%>
                            </td>
                            <td style="display: none">
                                <%# DataBinder.Eval(Container.DataItem, "Activo")%>
                            </td>
                            <td>
                                <asp:CheckBox ID="checkBoxActivo" Checked='<%#(bool)(DataBinder.Eval(Container.DataItem, "Activo"))%>'
                                    runat="server" Enabled="false" />
                            </td>
                            <td style="width: 70px;">
                                <a href="#" role="button" class="btn btn-default" data-toggle="modal" onclick="actualizarusuario(this);return true;"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span></a>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </tbody> </table>
                    </FooterTemplate>
                </asp:Repeater>
            </div>

            <asp:HiddenField ID="hfidusuario" runat="server" />

            <asp:HiddenField ID="hfarbol" runat="server" />

            <asp:HiddenField ID="hfnodosseleccionados" runat="server" />
        </div>
    </div>
</asp:Content>
