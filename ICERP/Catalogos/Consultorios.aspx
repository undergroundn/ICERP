<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Consultorios.aspx.cs" Inherits="ICERP.Catalogos.Consultorios" %>

<asp:Content ID="consultorioHeadContent" ContentPlaceHolderID="headContent" runat="server">
    <script src="../Scripts/pages/catalogos/consultorios.js"></script>
</asp:Content>
<asp:Content ID="consultorioBodyContent" ContentPlaceHolderID="bodyContent" runat="server">
    <section class="content">
        <div class="row">
            <div class="box box-danger">
                <div class="box-header with-border">
                    <h3 class="box-title">Registro de Consultorios</h3>
                </div>
                <!-- /.box-header -->
                <div class="box-body">
                    <div class="form-group">
                        <label for="txtNombreConsultorio">Nombre</label>
                        <input type="text" style="width: 100%; max-width: 300px" maxlength="100" class="form-control validate[required]" id="txtNombreConsultorio" placeholder="Nombre del Consultorio" validgroup="registrarConsultorio" />
                    </div>
                    <div class="form-group">
                        <label for="sltPlanta">Planta</label>
                        <select id="sltPlanta" class="form-control validate[required]" style="width: 100%; max-width: 300px" validgroup="registrarConsultorio">
                            <option value="">-- Seleccione --</option>
                            <option value="0">Baja</option>
                            <option value="1">Alta</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Tipo</label>
                        <br />
                        <div id="divTipoConsultorios" style="display: inline-block;">
                        </div>
                    </div>
                    <br />
                    <div class="form-group">
                        <input id="chkActivo" type="checkbox" class="flat-red" checked />
                        <span style="margin-right: 20px">Activo</span>
                    </div>
                </div>
                <!-- /.box-body -->

                <div class="box-footer">
                    <button id="btnRegistrarConsultorio" type="button" class="btn btn-success"><span><i class="glyphicon glyphicon-ok"></i></span>&nbsp;&nbsp;Registrar</button>
                </div>
            </div>
            <div class="box">
                <div class="box-header">
                    <h3 class="box-title">Consultorios</h3>
                </div>
                <!-- /.box-header -->
                <div class="box-body">
                    <div class="dataTables_wrapper form-inline dt-bootstrap">

                        <div style="width: 100%">
                            <br />

                            <table id="tblConsultorios" class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th>IdConsultorio</th>
                                        <th>Nombre</th>
                                        <th>Planta</th>
                                        <th>Tipo</th>
                                        <th>Registró</th>
                                        <th>Fecha</th>
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
                <!-- /.box-body -->
            </div>

        </div>

    </section>

    <div class="modal fade" id="mdlEditarConsultorio" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog" style="width: 350px">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Cerrar</span></button>
                    <h4 class="modal-title" id="myModalLabel1"><strong>Editar Consultorio</strong></h4>
                </div>
                <div class="modal-body">
                    <div>
                        <div class="box-body">
                            <div class="form-group">
                                <label for="txtNombreConsultorioEd">Nombre</label>
                                <input type="text" style="width: 100%; max-width: 300px" maxlength="100" class="form-control validate[required]" id="txtNombreConsultorioEd" placeholder="Nombre del Consultorio" validgroup="editarConsultorio" />
                            </div>
                            <div class="form-group">
                                <label for="sltPlantaEd">Planta</label>
                                <select id="sltPlantaEd" class="form-control validate[required]" style="width: 100%; max-width: 300px" validgroup="editarConsultorio">
                                    <option value="">-- Seleccione --</option>
                                    <option value="0">Baja</option>
                                    <option value="1">Alta</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Tipo</label>
                                <br />
                                <div id="divTipoConsultoriosEd" style="display: inline-block;">
                                </div>
                            </div>
                            <br />
                            <div class="form-group">
                                <input id="chkActivoEd" type="checkbox" />
                                <span style="margin-right: 20px">Activo</span>
                            </div>
                            <input id="hdnIdConsultorio" type="hidden" />
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">
                        <span class="glyphicon glyphicon-remove"></span>&nbsp;Cerrar
                    </button>
                    <button type="button" class="btn btn-primary" id="btnEditarConsultorio">
                        <span class="glyphicon glyphicon-floppy-saved"></span>&nbsp;Actualizar
                    </button>
                </div>
            </div>
        </div>

    </div>

</asp:Content>
