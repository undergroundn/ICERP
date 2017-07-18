<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="ResultadosEvaluacion.aspx.cs" Inherits="ICERP.Catalogos.ResultadosEvaluacion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headContent" runat="server">
     <script src="../Scripts/pages/catalogos/resultadosEvaluacion.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyContent" runat="server">
     <section class="content">
        <div class="row">
            <div class="box box-danger">
                <div class="box-header with-border">
                    <h3 class="box-title">Registro de Resultados de Evaluación</h3>
                </div>
                <!-- /.box-header -->
                <div class="box-body">
                    <div class="col-md-4">
                    <div class="form-group">
                        <label for="txtNombreTarifa">Nombre de tarifa</label>
                        <input type="text" style="width: 100%; max-width: 300px" maxlength="100" class="form-control validate[required]" id="txtNombreTarifa" placeholder="Tarifa de estudio socioeconomico" validgroup="registrarResultados" />
                    </div></div>
                        <div class="col-md-4">
                    <div class="form-group">
                        <label for="txtRangoInferior">Rango inferior</label>
                        <input type="text" style="width: 100%; max-width: 300px" maxlength="100" class="form-control validate[required]" id="txtRangoInferior" placeholder="Rango inferior de tarifa" validgroup="registrarResultados" />
                    </div></div>
                            <div class="col-md-4">
                    <div class="form-group">
                        <label for="txtRangoSuperior">Rango superior</label>
                        <input type="text" style="width: 100%; max-width: 300px" maxlength="100" class="form-control validate[required]" id="txtRangoSuperior" placeholder="Rango superior de tarifa" validgroup="registrarResultados" />
                    </div></div>
                                <div class="col-md-4">
                    <div class="form-group">
                        <label for="txtPrecioTarifa">Precio de tarifa</label>
                        <input type="text" style="width: 100%; max-width: 300px" maxlength="100" class="form-control validate[required]" id="txtPrecioTarifa" placeholder="Tarifa para el paciente" validgroup="registrarResultados" />
                    </div></div>
                                    <div class="col-md-4">
                    <div class="form-group">
                        <label for="txtDescuentoPorPersona">Descuento por persona extra</label>
                        <input type="text" style="width: 100%; max-width: 300px" maxlength="100" class="form-control validate[required]" id="txtDescuentoPorPersona" placeholder="Cantidad descuento por cada persona extra" validgroup="registrarResultados" />
                    </div></div>
                </div>
                <!-- /.box-body -->

                <div class="box-footer">
                    <button id="btnRegistrarResultados" type="button" class="btn btn-success"><span><i class="glyphicon glyphicon-ok"></i></span>&nbsp;&nbsp;Registrar</button>
                </div>
            </div>
            <div class="box">
                <div class="box-header">
                    <h3 class="box-title">Tabla de Resultados de Evaluación</h3>
                </div>
                <!-- /.box-header -->
                <div class="box-body">
                    <div class="dataTables_wrapper form-inline dt-bootstrap">

                        <div style="width: 100%">
                            <br />

                            <table id="tblResultados" class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th style="display:none">ID</th>
                                        <th>Nombre de Tarifa</th>
                                        <th>Rango Inferior</th>
                                        <th>Rango Superior</th>
                                        <th>Precio Tarifa</th>
                                        <th>Descuento por Persona Extra</th>                                        
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

    <div class="modal fade" id="mdlEditarResultados" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog" style="width: 350px">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Cerrar</span></button>
                    <h4 class="modal-title" id="myModalLabel1"><strong>Editar Resultados de Evaluación</strong></h4>
                </div>
                <div class="modal-body">
                    <div>
                        <div class="box-body">
                            <div class="form-group">
                                <label for="txtNombreResultadoEd">Nombre de tarifa</label>
                                <input type="text" style="width: 100%; max-width: 300px" maxlength="100" class="form-control validate[required]" id="txtNombreResultadoEd" placeholder="Nombre de la Tarifa" validgroup="editarResultados" />
                            </div>
                             <div class="form-group">
                                <label for="txtRangoInferiorEd">Rango inferior</label>
                                <input type="text" style="width: 100%; max-width: 300px" maxlength="100" class="form-control validate[required]" id="txtRangoInferiorEd" placeholder="Nombre de la Tarifa" validgroup="editarResultados" />
                            </div>
                             <div class="form-group">
                                <label for="txtRangoSuperiorEd">Rango superior</label>
                                <input type="text" style="width: 100%; max-width: 300px" maxlength="100" class="form-control validate[required]" id="txtRangoSuperiorEd" placeholder="Nombre de la Tarifa" validgroup="editarResultados" />
                            </div>
                             <div class="form-group">
                                <label for="txtPrecioTarifaEd">Precio de tarifa</label>
                                <input type="text" style="width: 100%; max-width: 300px" maxlength="100" class="form-control validate[required]" id="txtPrecioTarifaEd" placeholder="Nombre de la Tarifa" validgroup="editarResultados" />
                            </div>
                             <div class="form-group">
                                <label for="txtDescuentoPorPersonaEd">Descuento por persona extra</label>
                                <input type="text" style="width: 100%; max-width: 300px" maxlength="100" class="form-control validate[required]" id="txtDescuentoPorPersonaEd" placeholder="Nombre de la Tarifa" validgroup="editarResultados" />
                            </div>
                            <input id="hdnIdResultado" type="hidden" />
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">
                        <span class="glyphicon glyphicon-remove"></span>&nbsp;Cerrar
                    </button>
                    <button type="button" class="btn btn-primary" id="btnEditarResultado">
                        <span class="glyphicon glyphicon-floppy-saved"></span>&nbsp;Actualizar
                    </button>
                </div>
            </div>
        </div>

    </div>
</asp:Content>
