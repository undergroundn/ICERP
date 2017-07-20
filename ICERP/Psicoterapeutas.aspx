<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Psicoterapeutas.aspx.cs" Inherits="ICERP.Psicoterapeutas" %>

<asp:Content ID="PsicoterapeutasHeadContent" ContentPlaceHolderID="headContent" runat="server">

    <script type="text/javascript">

        $(document).ready(function () {

            ICERP_Core.llamarAjax("Psicoterapeutas.aspx/obtenerDatosControles", null, "crearControles");

            ICERP_Core.llamarAjax("Psicoterapeutas.aspx/obtenerPsicoterapeutas", null, "crearTablaPsicoterapeutas");

            $("#btnAgregarPsico").click(function () {
                limpiarModalAgregarPsico();
                $("#mdlAgregarPsico").modal("show");
            });

            $("#btnGuardarTerapeuta").click(function(ev) {
                var isValid = ICERP_Core.validarFormulario('registrarTerapeuta');
                if (!isValid) {
                    ICERP_Core.reiniciarValidación('registrarTerapeuta');
                    ev.preventDefault();
                    return;
                }
                guardarTerapeuta();
            });

            $("#btnEditarTerapeuta").click(function (ev) {
                var isValid = ICERP_Core.validarFormulario('editarTerapeuta');
                if (!isValid) {
                    ICERP_Core.reiniciarValidación('editarTerapeuta');
                    ev.preventDefault();
                    return;
                }
                actualizarPsicoterapeuta();
            });
        });

        //Resultado de la llamada a Psicoterapeutas.aspx/obtenerDatosControles
        function crearControles(resultado) {
            var contenido = JSON.parse(resultado);

            $.each(contenido.TiposTurnos, function (i, item) {
                $('#sltTurno').append($('<option>', {
                    value: item.ID,
                    text: item.Tipo
                }));
            });

            $.each(contenido.TiposTurnos, function (i, item) {
                $('#sltTurnoEd').append($('<option>', {
                    value: item.ID,
                    text: item.Tipo
                }));
            });

            $.each(contenido.TiposCuotas, function (i, item) {
                $('#sltCuota').append($('<option>', {
                    value: item.ID,
                    text: item.Tipo
                }));
            });

            $.each(contenido.TiposCuotas, function (i, item) {
                $('#sltCuotaEd').append($('<option>', {
                    value: item.ID,
                    text: item.Tipo
                }));
            });

            $.each(contenido.TiposPacientes, function (index, item) {
                var checkBoxAd = "<input id=\"chk" + item.Tipo + "Ad\" value=\"" + item.ID + "\" type=\"checkbox\" class=\"flat-red tiposPacientes validate[funcCall[verificarTipoPaciente]]\" validgroup=\"registrarTerapeuta\" />" +
                                    "<span style=\"margin-left: 5px\">" + item.Tipo + "</span>" + "</br>";
                $("#divTiposPacientes").append(checkBoxAd);
                var checkBoxEd = "<input id=\"chk" + item.Tipo + "Ed\" value=\"" + item.ID + "\" type=\"checkbox\" class=\"flat-red tiposPacientesEd validate[funcCall[verificarTipoPacienteEd]]\" validgroup=\"editarTerapeuta\" />" +
                                    "<span style=\"margin-left: 5px\">" + item.Tipo + "</span>" + "</br>";
                $("#divTiposPacientesEd").append(checkBoxEd);
            });
            $('#divTiposPacientes input[type="checkbox"].flat-red').iCheck({
                checkboxClass: 'icheckbox_flat-red'
            });

            $.each(contenido.TiposAreas, function (index, item) {
                var checkBoxAd = "<input id=\"chk" + item.Tipo + "Ad\" value=\"" + item.ID + "\" type=\"checkbox\" class=\"flat-red tiposAreas validate[funcCall[verificarTipoArea]]\" validgroup=\"registrarTerapeuta\" />" +
                                    "<span style=\"margin-left: 5px\">" + item.Tipo + "</span>" + "</br>";
                $("#divTiposÁreas").append(checkBoxAd);
                var checkBoxEd = "<input id=\"chk" + item.Tipo + "Ed\" value=\"" + item.ID + "\" type=\"checkbox\" class=\"flat-red tiposAreasEd validate[funcCall[verificarTipoAreaEd]]\" validgroup=\"editarTerapeuta\" />" +
                                    "<span style=\"margin-left: 5px\">" + item.Tipo + "</span>" + "</br>";
                $("#divTiposÁreasEd").append(checkBoxEd);
            });
            $('#divTiposÁreas input[type="checkbox"].flat-red').iCheck({
                checkboxClass: 'icheckbox_flat-red'
            });

            $.each(contenido.TiposTrastornos, function (index, item) {
                var checkBoxAd = "<input id=\"chk" + item.Tipo + "Ad\" value=\"" + item.ID + "\" type=\"checkbox\" class=\"flat-red tiposTrastornos validate[funcCall[verificarTipoTrastorno]]\" validgroup=\"registrarTerapeuta\" />" +
                                    "<span style=\"margin-left: 5px\">" + item.Tipo + "</span>" + "</br>";
                $("#divTiposTrastornos").append(checkBoxAd);
                var checkBoxEd = "<input id=\"chk" + item.Tipo + "Ed\" value=\"" + item.ID + "\" type=\"checkbox\" class=\"flat-red tiposTrastornosEd validate[funcCall[verificarTipoTrastornoEd]]\" validgroup=\"editarTerapeuta\" />" +
                                    "<span style=\"margin-left: 5px\">" + item.Tipo + "</span>" + "</br>";
                $("#divTiposTrastornosEd").append(checkBoxEd);
            });
            $('#divTiposTrastornos input[type="checkbox"].flat-red').iCheck({
                checkboxClass: 'icheckbox_flat-red'
            });

        }

        //Resultado de la llamada a Psicoterapeutas.aspx/obtenerPsicoterapeutas
        function crearTablaPsicoterapeutas(resultado) {
            var contenido = JSON.parse(resultado);
            $('#tblPsicoterapeutas tbody').html("");
            $.each(contenido, function (key, item) {
                var $tr = $('<tr>');
                $.each(item, function (index, data) {
                    $tr.append($('<td>').text(data));
                });
                $tr.append($('<td style="text-align:center">').html('<a role="button" class="btn btn-default btnModalEditarTerapeuta" data-toggle="modal"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span></a>'));
                $tr.appendTo('#tblPsicoterapeutas tbody');
            });

            $("#tblPsicoterapeutas").DataTable({
                "language": {
                    "url": "//cdn.datatables.net/plug-ins/1.10.15/i18n/Spanish.json"
                },
                "responsive": true,
                "columnDefs": [
                    { "visible": false, "targets": 0 }
                ]
            });

            clickEditarPsicoterapeuta();
        }

        function guardarTerapeuta() {
            var nombre = $("#inputNombre").val().trim();
            var apPaterno = $("#inputApPaterno").val().trim();
            var apMaterno = $("#inputApMaterno").val().trim();
            var telefono = $("#inputTelefono").val().trim();
            var celular = $("#inputCelular").val().trim();
            var whatsApp = ($("#sltWhatsApp").val() == "1");
            var turno = Number($("#sltTurno").val());
            var cuota = Number($("#sltCuota").val());
            var activo = $("#chkActivo").prop('checked');

            var psicoterapeuta = new Object();
            psicoterapeuta.Nombre = nombre;
            psicoterapeuta.ApPaterno = apPaterno;
            psicoterapeuta.ApMaterno = apMaterno;
            psicoterapeuta.Telefono = telefono;
            psicoterapeuta.Celular = celular;
            psicoterapeuta.Whatsapp = whatsApp;
            psicoterapeuta.IdTurno = turno;
            psicoterapeuta.IdTipoCuota = cuota;
            psicoterapeuta.Activo = activo;
            psicoterapeuta.PsicoterapeutasTiposPacientes = [];
            psicoterapeuta.PsicoterapeutasTiposAreas = [];
            psicoterapeuta.PsicoterapeutasTiposTrastornos = [];

            $(".tiposPacientes").each(function () {
                var checked = $(this).prop('checked');
                if (checked) {
                    var idTipoPaciente = Number($(this).val());
                    var tipoPaciente = new Object();
                    tipoPaciente.IdTipoPaciente = idTipoPaciente;
                    tipoPaciente.Activo = true;
                    psicoterapeuta.PsicoterapeutasTiposPacientes.push(tipoPaciente);
                }
            });

            $(".tiposAreas").each(function () {
                var checked = $(this).prop('checked');
                if (checked) {
                    var idTipoArea = Number($(this).val());
                    var tipoArea = new Object();
                    tipoArea.IdTipoArea = idTipoArea;
                    tipoArea.Activo = true;
                    psicoterapeuta.PsicoterapeutasTiposAreas.push(tipoArea);
                }
            });

            $(".tiposTrastornos").each(function () {
                var checked = $(this).prop('checked');
                if (checked) {
                    var idTipoTrastorno = Number($(this).val());
                    var tipoTrastorno = new Object();
                    tipoTrastorno.IdTipoTrastorno = idTipoTrastorno;
                    tipoTrastorno.Activo = true;
                    psicoterapeuta.PsicoterapeutasTiposTrastornos.push(tipoTrastorno);
                }
            });

            ICERP_Core.bloquearPantalla();
            ICERP_Core.llamarAjax("Psicoterapeutas.aspx/guardarPsicoterapeuta", "{ 'psicoterapeuta': " + JSON.stringify(psicoterapeuta) + "}", "psicoterapeutaGuardado");
        }

        //Resultado de la llamada a Psicoterapeutas.aspx/guardarPsicoterapeuta de la función "guardarTerapeuta"
        function psicoterapeutaGuardado() {
            $("#mdlAgregarPsico").modal("hide");
            $('#tblPsicoterapeutas').DataTable().destroy();
            ICERP_Core.llamarAjax("Psicoterapeutas.aspx/obtenerPsicoterapeutas", null, "crearTablaPsicoterapeutas");
            ICERP_Core.desbloquearPantalla();
            ICERP_Core.mostrarMensaje("Se registró el Psicoterapeuta satisfactoriamente.", "type-success");
        }

        function clickEditarPsicoterapeuta() {
            $(".btnModalEditarTerapeuta").click(function () {
                var row = $(this).closest('tr');
                var data = $('#tblPsicoterapeutas').dataTable().fnGetData(row);
                var idPsicoterapeuta = Number(data[0]);
                ICERP_Core.llamarAjax("Psicoterapeutas.aspx/obtenerDatosPsicoterapeuta", "{ 'IdPsicoterapeuta': " + idPsicoterapeuta + " }", "mostrarDatosPsicoterapeuta");
            });
        }

        //Resultado de la llamada a Psicoterapeutas.aspx/obtenerDatosPsicoterapeuta de la función "clickEditarPsicoterapeuta"
        function mostrarDatosPsicoterapeuta(resultado) {
            var psicoterapeuta = JSON.parse(resultado);
            $("#hdnIdTerapeuta").val(psicoterapeuta.ID);
            $("#inputNombreEd").val(psicoterapeuta.Nombre);
            $("#inputApPaternoEd").val(psicoterapeuta.ApPaterno);
            $("#inputApMaternoEd").val(psicoterapeuta.ApMaterno);
            $("#inputTelefonoEd").val(psicoterapeuta.Telefono);
            $("#inputCelularEd").val(psicoterapeuta.Celular);
            $("#sltWhatsAppEd").val(+psicoterapeuta.Whatsapp);
            $("#sltTurnoEd").val(psicoterapeuta.IdTurno);
            $("#sltCuotaEd").val(psicoterapeuta.IdTipoCuota);

            $('#divTiposPacientesEd input[type=checkbox]').each(function () {
                $(this).prop("checked", false);
            });
            $.each(psicoterapeuta.TiposPacientes, function (index, value) {
                var checkBox = $("#divTiposPacientesEd input[type=checkbox][value=" + value + "]");
                $(checkBox).prop("checked", true);
                $(checkBox).removeClass("flat-red").addClass("flat-red");
            });

            $('#divTiposÁreasEd input[type=checkbox]').each(function () {
                $(this).prop("checked", false);
            });
            $.each(psicoterapeuta.TiposAreas, function (index, value) {
                var checkBox = $("#divTiposÁreasEd input[type=checkbox][value=" + value + "]");
                $(checkBox).prop("checked", true);
                $(checkBox).removeClass("flat-red").addClass("flat-red");
            });

            $('#divTiposTrastornosEd input[type=checkbox]').each(function () {
                $(this).prop("checked", false);
            });
            $.each(psicoterapeuta.TiposTrastornos, function (index, value) {
                var checkBox = $("#divTiposTrastornosEd input[type=checkbox][value=" + value + "]");
                $(checkBox).prop("checked", true);
                $(checkBox).removeClass("flat-red").addClass("flat-red");
            });

            $("#chkActivoEd").prop("checked", false);
            if (psicoterapeuta.Activo) {
                $("#chkActivoEd").prop("checked", true);
                $("#chkActivoEd").removeClass("flat-red").addClass("flat-red");
            }
            $('#mdlEditarPsico input[type="checkbox"].flat-red').iCheck({
                checkboxClass: 'icheckbox_flat-red'
            });
            $("#mdlEditarPsico").validationEngine("hideAll");
            $("#mdlEditarPsico").modal("show");
        }

        function actualizarPsicoterapeuta() {
            var idTerapeuta = Number($("#hdnIdTerapeuta").val());
            var nombre = $("#inputNombreEd").val().trim();
            var apPaterno = $("#inputApPaternoEd").val().trim();
            var apMaterno = $("#inputApMaternoEd").val().trim();
            var telefono = $("#inputTelefonoEd").val().trim();
            var celular = $("#inputCelularEd").val().trim();
            var whatsApp = ($("#sltWhatsAppEd").val() == "1");
            var turno = Number($("#sltTurnoEd").val());
            var cuota = Number($("#sltCuotaEd").val());
            var activo = $("#chkActivoEd").prop('checked');

            var psicoterapeuta = new Object();
            psicoterapeuta.ID = idTerapeuta;
            psicoterapeuta.Nombre = nombre;
            psicoterapeuta.ApPaterno = apPaterno;
            psicoterapeuta.ApMaterno = apMaterno;
            psicoterapeuta.Telefono = telefono;
            psicoterapeuta.Celular = celular;
            psicoterapeuta.Whatsapp = whatsApp;
            psicoterapeuta.IdTurno = turno;
            psicoterapeuta.IdTipoCuota = cuota;
            psicoterapeuta.Activo = activo;
            psicoterapeuta.PsicoterapeutasTiposPacientes = [];
            psicoterapeuta.PsicoterapeutasTiposAreas = [];
            psicoterapeuta.PsicoterapeutasTiposTrastornos = [];

            $(".tiposPacientesEd").each(function () {
                var checked = $(this).prop('checked');
                if (checked) {
                    var idTipoPaciente = Number($(this).val());
                    var tipoPaciente = new Object();
                    tipoPaciente.IdTipoPaciente = idTipoPaciente;
                    tipoPaciente.Activo = true;
                    psicoterapeuta.PsicoterapeutasTiposPacientes.push(tipoPaciente);
                }
            });

            $(".tiposAreasEd").each(function () {
                var checked = $(this).prop('checked');
                if (checked) {
                    var idTipoArea = Number($(this).val());
                    var tipoArea = new Object();
                    tipoArea.IdTipoArea = idTipoArea;
                    tipoArea.Activo = true;
                    psicoterapeuta.PsicoterapeutasTiposAreas.push(tipoArea);
                }
            });

            $(".tiposTrastornosEd").each(function () {
                var checked = $(this).prop('checked');
                if (checked) {
                    var idTipoTrastorno = Number($(this).val());
                    var tipoTrastorno = new Object();
                    tipoTrastorno.IdTipoTrastorno = idTipoTrastorno;
                    tipoTrastorno.Activo = true;
                    psicoterapeuta.PsicoterapeutasTiposTrastornos.push(tipoTrastorno);
                }
            });

            ICERP_Core.bloquearPantalla();
            ICERP_Core.llamarAjax("Psicoterapeutas.aspx/actualizarPsicoterapeuta", "{ 'psicoterapeuta': " + JSON.stringify(psicoterapeuta) + "}", "psicoterapeutaActualizado");
        }

        function psicoterapeutaActualizado() {
            $('#tblPsicoterapeutas').DataTable().destroy();
            ICERP_Core.llamarAjax("Psicoterapeutas.aspx/obtenerPsicoterapeutas", null, "crearTablaPsicoterapeutas");
            ICERP_Core.desbloquearPantalla();
            $("#mdlEditarPsico").modal("hide");
            ICERP_Core.mostrarMensaje("Se actualizó el Psicoterapeuta satisfactoriamente.", "type-success");
        }

        function limpiarModalAgregarPsico() {
            $("#mdlAgregarPsico").validationEngine("hideAll");

            $("#inputNombre").val("");
            $("#inputApPaterno").val("");
            $("#inputApMaterno").val("");
            $("#inputTelefono").val("");
            $("#inputCelular").val("");
            $("#sltWhatsApp").prop('selectedIndex', 0);
            $("#sltTurno").prop('selectedIndex', 0);
            $("#sltCuota").prop('selectedIndex', 0);
            $("#chkActivo").prop('checked', true);
            $(".tiposPacientes").each(function () {
                $(this).prop('checked', false);
            });
            $(".tiposAreas").each(function () {
                $(this).prop('checked', false);
            });
            $(".tiposTrastornos").each(function () {
                $(this).prop('checked', false);
            });

            $('#mdlAgregarPsico input[type="checkbox"].flat-red').iCheck({
                checkboxClass: 'icheckbox_flat-red'
            });
        }

        //funcion personalizada para validar tipos de pacientes seleccionados
        function verificarTipoPaciente(field, rules, i, options) {
            var valid = false;
            $(".tiposPacientes").each(function () {
                var checked = $(this).prop('checked');
                if (checked) {
                    valid = true;
                    return false;
                }
            });
            if (!valid) {
                $("#divTiposPacientes").validationEngine('showPrompt', '* Seleccione al menos un tipo de Paciente.', 'error', 'topRight', true);
                options.isError = true;
            } else {
                $('#divTiposPacientes').validationEngine('hide');
            }
        }

        //funcion personalizada para validar tipos de área seleccionados
        function verificarTipoArea(field, rules, i, options) {
            var valid = false;
            $(".tiposAreas").each(function () {
                var checked = $(this).prop('checked');
                if (checked) {
                    valid = true;
                    return false;
                }
            });
            if (!valid) {
                $("#divTiposÁreas").validationEngine('showPrompt', '* Seleccione al menos un tipo de Área.', 'error', 'topRight', true);
                options.isError = true;
            } else {
                $('#divTiposÁreas').validationEngine('hide');
            }
        }

        //funcion personalizada para validar tipos de trastornos seleccionados
        function verificarTipoTrastorno(field, rules, i, options) {
            var valid = false;
            $(".tiposTrastornos").each(function () {
                var checked = $(this).prop('checked');
                if (checked) {
                    valid = true;
                    return false;
                }
            });
            if (!valid) {
                $("#divTiposTrastornos").validationEngine('showPrompt', '* Seleccione al menos un tipo de Trastorno.', 'error', 'topRight', true);
                options.isError = true;
            } else {
                $('#divTiposTrastornos').validationEngine('hide');
            }
        }

        //funcion personalizada para validar tipos de pacientes seleccionados al editar
        function verificarTipoPacienteEd(field, rules, i, options) {
            var valid = false;
            $(".tiposPacientesEd").each(function () {
                var checked = $(this).prop('checked');
                if (checked) {
                    valid = true;
                    return false;
                }
            });
            if (!valid) {
                $("#divTiposPacientesEd").validationEngine('showPrompt', '* Seleccione al menos un tipo de Paciente.', 'error', 'topRight', true);
                options.isError = true;
            } else {
                $('#divTiposPacientesEd').validationEngine('hide');
            }
        }

        //funcion personalizada para validar tipos de área seleccionados al editar
        function verificarTipoAreaEd(field, rules, i, options) {
            var valid = false;
            $(".tiposAreasEd").each(function () {
                var checked = $(this).prop('checked');
                if (checked) {
                    valid = true;
                    return false;
                }
            });
            if (!valid) {
                $("#divTiposÁreasEd").validationEngine('showPrompt', '* Seleccione al menos un tipo de Área.', 'error', 'topRight', true);
                options.isError = true;
            } else {
                $('#divTiposÁreasEd').validationEngine('hide');
            }
        }

        //funcion personalizada para validar tipos de trastornos seleccionados al editar
        function verificarTipoTrastornoEd(field, rules, i, options) {
            var valid = false;
            $(".tiposTrastornosEd").each(function () {
                var checked = $(this).prop('checked');
                if (checked) {
                    valid = true;
                    return false;
                }
            });
            if (!valid) {
                $("#divTiposTrastornosEd").validationEngine('showPrompt', '* Seleccione al menos un tipo de Trastorno.', 'error', 'topRight', true);
                options.isError = true;
            } else {
                $('#divTiposTrastornosEd').validationEngine('hide');
            }
        }

    </script>

</asp:Content>
<asp:Content ID="PsicoterapeutasBodyContent" ContentPlaceHolderID="bodyContent" runat="server">
    <div class="box box-danger">
        <div class="box-header with-border">
            <h3 class="box-title">Registro de Psicoterapeutas</h3>
        </div>
        <div class="box-body">
            <div>
                <button id="btnAgregarPsico" type="button" class="btn btn-success"><span><i class="glyphicon glyphicon-plus"></i></span>&nbsp;&nbsp;Nuevo Psicoterapeuta</button>
            </div>
            <br />
            <div class="dataTables_wrapper form-inline dt-bootstrap">

                <div style="width: 100%">
                    <br />

                    <table id="tblPsicoterapeutas" class="table table-bordered table-hover">
                        <thead>
                            <tr>
                                <th>IdPsicoterapeuta</th>
                                <th>Nombre(s)</th>
                                <th>Ap. Paterno</th>
                                <th>Ap. Materno</th>
                                <th>Teléfono</th>
                                <th>Celular</th>
                                <th>Turno</th>
                                <th>Cuota</th>
                                <th>Activo</th>
                                <th>Editar</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>

                </div>
            </div>
        </div>

        <div class="modal fade" id="mdlAgregarPsico" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog" style="width: 550px">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Cerrar</span></button>
                        <h4 class="modal-title" id="myModalLabel1"><strong>Agregar Psicoterapeuta</strong></h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-horizontal">
                            <div class="box-body">
                                <div class="form-group">
                                    <label for="inputNombre" class="col-sm-4 control-label">Nombre(s)</label>
                                    <div class="col-sm-8">
                                        <input class="form-control validate[required]" id="inputNombre" placeholder="Nombre" maxlength="100" validgroup="registrarTerapeuta" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputApPaterno" class="col-sm-4 control-label">Apellido Paterno</label>
                                    <div class="col-sm-8">
                                        <input class="form-control validate[required]" id="inputApPaterno" placeholder="Apellido Paterno" maxlength="100" validgroup="registrarTerapeuta" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputApMaterno" class="col-sm-4 control-label">Apellido Materno</label>
                                    <div class="col-sm-8">
                                        <input class="form-control" id="inputApMaterno" placeholder="Apellido Materno" maxlength="100"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputTelefono" class="col-sm-4 control-label">Teléfono</label>
                                    <div class="col-sm-8">
                                        <div class="input-group">
                                            <div class="input-group-addon">
                                                <i class="fa fa-phone"></i>
                                            </div>
                                            <input class="form-control validate[required]" id="inputTelefono" placeholder="Teléfono" maxlength="50" data-inputmask='"mask": "(999) 999-9999"' data-mask validgroup="registrarTerapeuta" />
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputCelular" class="col-sm-4 control-label">Celular</label>
                                    <div class="col-sm-8">
                                        <div class="input-group">
                                            <div class="input-group-addon">
                                                <i class="fa fa-phone"></i>
                                            </div>
                                            <input class="form-control validate[required]" id="inputCelular" placeholder="Celular" maxlength="50" data-inputmask='"mask": "(999) 999-9999"' data-mask validgroup="registrarTerapeuta" />
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="sltWhatsApp" class="col-sm-4 control-label">¿Cuenta con Whatsapp?</label>

                                    <div class="col-sm-8">
                                        <select id="sltWhatsApp" class="form-control">
                                            <option value="1">Si</option>
                                            <option value="0">No</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="sltTurno" class="col-sm-4 control-label">Turno</label>

                                    <div class="col-sm-8" id="divSltTurno">
                                        <select class="form-control" id="sltTurno">
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="sltCuota" class="col-sm-4 control-label">Cuota</label>

                                    <div class="col-sm-8" id="divSltTipoCuota">
                                        <select class="form-control" id="sltCuota">
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-4 control-label">Tipos de Pacientes</label>
                                    <div class="col-sm-8" id="divTiposPacientes" style="display: inline-block;">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-4 control-label">Tipos de Áreas</label>
                                    <div class="col-sm-8" id="divTiposÁreas" style="display: inline-block;">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-4 control-label">Tipos de Trastornos</label>
                                    <div class="col-sm-8" id="divTiposTrastornos" style="display: inline-block;">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-4"></div>
                                    <div class="col-sm-8" style="margin-top: 20px">
                                        <input id="chkActivo" type="checkbox" class="flat-red" checked />
                                        <span style="margin-right: 20px">Activo</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">
                            <span class="glyphicon glyphicon-remove"></span>&nbsp;Cerrar
                        </button>
                        <button type="button" class="btn btn-primary" id="btnGuardarTerapeuta">
                            <span class="glyphicon glyphicon-floppy-saved"></span>&nbsp;Guardar
                        </button>
                    </div>
                </div>
            </div>

        </div>
        
        
        <div class="modal fade" id="mdlEditarPsico" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog" style="width: 550px">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Cerrar</span></button>
                        <h4 class="modal-title"><strong>Editar Psicoterapeuta</strong></h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-horizontal">
                            <div class="box-body">
                                <div class="form-group">
                                    <label for="inputNombreEd" class="col-sm-4 control-label">Nombre(s)</label>
                                    <div class="col-sm-8">
                                        <input class="form-control validate[required]" id="inputNombreEd" placeholder="Nombre" maxlength="100" validgroup="editarTerapeuta" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputApPaternoEd" class="col-sm-4 control-label">Apellido Paterno</label>
                                    <div class="col-sm-8">
                                        <input class="form-control validate[required]" id="inputApPaternoEd" placeholder="Apellido Paterno" maxlength="100" validgroup="editarTerapeuta" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputApMaternoEd" class="col-sm-4 control-label">Apellido Materno</label>
                                    <div class="col-sm-8">
                                        <input class="form-control" id="inputApMaternoEd" placeholder="Apellido Materno" maxlength="100"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputTelefonoEd" class="col-sm-4 control-label">Teléfono</label>
                                    <div class="col-sm-8">
                                        <div class="input-group">
                                            <div class="input-group-addon">
                                                <i class="fa fa-phone"></i>
                                            </div>
                                            <input class="form-control validate[required]" id="inputTelefonoEd" placeholder="Teléfono" maxlength="50" data-inputmask='"mask": "(999) 999-9999"' data-mask validgroup="editarTerapeuta" />
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputCelularEd" class="col-sm-4 control-label">Celular</label>
                                    <div class="col-sm-8">
                                        <div class="input-group">
                                            <div class="input-group-addon">
                                                <i class="fa fa-phone"></i>
                                            </div>
                                            <input class="form-control validate[required]" id="inputCelularEd" placeholder="Celular" maxlength="50" data-inputmask='"mask": "(999) 999-9999"' data-mask validgroup="editarTerapeuta" />
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="sltWhatsAppEd" class="col-sm-4 control-label">¿Cuenta con Whatsapp?</label>

                                    <div class="col-sm-8">
                                        <select id="sltWhatsAppEd" class="form-control">
                                            <option value="1">Si</option>
                                            <option value="0">No</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="sltTurnoEd" class="col-sm-4 control-label">Turno</label>

                                    <div class="col-sm-8" id="divSltTurnoEd">
                                        <select class="form-control" id="sltTurnoEd">
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="sltCuotaEd" class="col-sm-4 control-label">Cuota</label>

                                    <div class="col-sm-8" id="divSltTipoCuotaEd">
                                        <select class="form-control" id="sltCuotaEd">
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-4 control-label">Tipos de Pacientes</label>
                                    <div class="col-sm-8" id="divTiposPacientesEd" style="display: inline-block;">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-4 control-label">Tipos de Áreas</label>
                                    <div class="col-sm-8" id="divTiposÁreasEd" style="display: inline-block;">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-4 control-label">Tipos de Trastornos</label>
                                    <div class="col-sm-8" id="divTiposTrastornosEd" style="display: inline-block;">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-4"></div>
                                    <div class="col-sm-8" style="margin-top: 20px">
                                        <input id="chkActivoEd" type="checkbox" class="flat-red" checked />
                                        <span style="margin-right: 20px">Activo</span>
                                    </div>
                                    <input id="hdnIdTerapeuta" type="hidden" />
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">
                            <span class="glyphicon glyphicon-remove"></span>&nbsp;Cerrar
                        </button>
                        <button type="button" class="btn btn-primary" id="btnEditarTerapeuta">
                            <span class="glyphicon glyphicon-floppy-saved"></span>&nbsp;Actualizar
                        </button>
                    </div>
                </div>
            </div>

        </div>


    </div>
</asp:Content>
