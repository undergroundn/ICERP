using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Permissions;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using ICERP.Utilities;
using Microsoft.Owin.Security.OAuth;
using Model;
using Model.UnitOfWork;

namespace ICERP
{
    public partial class Psicoterapeutas : System.Web.UI.Page
    {
        private static readonly LoggerUtility.ILogger Log = LoggerUtility.Logger.GetInstance();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string obtenerDatosControles()
        {
            try
            {
                var uow = new UnitOfWork();
                var tiposTurnos = uow.TurnosRepository.Get().Where(t => t.Activo).Select(t => new { t.ID, Tipo = t.Turno });
                var tiposCuotas = uow.TipoCoutaRepository.Get().Where(tc => tc.Activo).Select(tc => new { tc.ID, tc.Tipo });
                var tiposPacientes = uow.TipoPacienteRepository.Get().Where(tp => tp.Activo).Select(tp => new { tp.ID, tp.Tipo });
                var tiposAreas = uow.TipoAreasRepository.Get().Where(ta => ta.Activo).Select(ta => new { ta.ID, ta.Tipo });
                var tiposTrastornos = uow.TipoTrastornoRepository.Get().Where(tt => tt.Activo).Select(tt => new { tt.ID, tt.Tipo });

                var js = new JavaScriptSerializer();
                var datosControles = "{\"TiposTurnos\":" + js.Serialize(tiposTurnos) + "," +
                    "\"TiposCuotas\":" + js.Serialize(tiposCuotas) + "," +
                    "\"TiposPacientes\":" + js.Serialize(tiposPacientes) + "," +
                    "\"TiposAreas\":" + js.Serialize(tiposAreas) + "," +
                    "\"TiposTrastornos\":" + js.Serialize(tiposTrastornos) + "}";

                return datosControles;
            }
            catch (Exception ex)
            {
                Log.Error("[ System ] " + " [ Page ] " + "[ " + System.Reflection.MethodBase.GetCurrentMethod().DeclaringType.Name.ToString() + " ] [ " + System.Reflection.MethodBase.GetCurrentMethod().Name.ToString() + " ] [ Fin ]", ex);
                throw;
            }
        }

        [WebMethod]
        public static string obtenerPsicoterapeutas()
        {
            try
            {
                var uow = new UnitOfWork();
                var psicoterapeutas = uow.PsicoterapeutaRepository.Get().Select(p => new { p.ID, p.Nombre, p.ApPaterno, p.ApMaterno, p.Telefono, p.Celular, p.Turnos.Turno, Cuota = p.TipoCouta.Tipo, Activo = p.Activo ? "Si" : "No" });
                return new JavaScriptSerializer().Serialize(psicoterapeutas);
            }
            catch (Exception ex)
            {
                Log.Error("[ System ] " + " [ Page ] " + "[ " + System.Reflection.MethodBase.GetCurrentMethod().DeclaringType.Name.ToString() + " ] [ " + System.Reflection.MethodBase.GetCurrentMethod().Name.ToString() + " ] [ Fin ]", ex);
                throw;
            }
        }

        [WebMethod]
        public static void guardarPsicoterapeuta(Model.Psicoterapeuta psicoterapeuta)
        {
            try
            {
                var uow = new UnitOfWork();
                psicoterapeuta.IdUsuario = Queries.GetCurrentUser().ID;
                psicoterapeuta.FechaAlta = DateTime.Now;
                uow.PsicoterapeutaRepository.Add(psicoterapeuta);
                uow.Save();
            }
            catch (Exception ex)
            {
                Log.Error("[ System ] " + " [ Page ] " + "[ " + System.Reflection.MethodBase.GetCurrentMethod().DeclaringType.Name.ToString() + " ] [ " + System.Reflection.MethodBase.GetCurrentMethod().Name.ToString() + " ] [ Fin ]", ex);
                throw;
            }
        }

        [WebMethod]
        public static string obtenerDatosPsicoterapeuta(int IdPsicoterapeuta)
        {
            try
            {
                var uow = new UnitOfWork();
                var psicoterapeuta = uow.PsicoterapeutaRepository.GetSingle(IdPsicoterapeuta);
                var resultado = new { psicoterapeuta.ID, psicoterapeuta.Nombre, psicoterapeuta.ApPaterno, psicoterapeuta.ApMaterno, psicoterapeuta.Telefono, psicoterapeuta.Celular, psicoterapeuta.Whatsapp, psicoterapeuta.IdTurno, psicoterapeuta.IdTipoCuota, psicoterapeuta.Activo, TiposAreas = psicoterapeuta.PsicoterapeutasTiposAreas.Where(p => p.Activo).Select(p => p.IdTipoArea), TiposPacientes = psicoterapeuta.PsicoterapeutasTiposPacientes.Where(p => p.Activo).Select(p => p.IdTipoPaciente), TiposTrastornos = psicoterapeuta.PsicoterapeutasTiposTrastornos.Where(p => p.Activo).Select(p => p.IdTipoTrastorno) };
                return new JavaScriptSerializer().Serialize(resultado);
            }
            catch (Exception ex)
            {
                Log.Error("[ System ] " + " [ Page ] " + "[ " + System.Reflection.MethodBase.GetCurrentMethod().DeclaringType.Name.ToString() + " ] [ " + System.Reflection.MethodBase.GetCurrentMethod().Name.ToString() + " ] [ Fin ]", ex);
                throw;
            }
        }

        [WebMethod]
        public static void actualizarPsicoterapeuta(Model.Psicoterapeuta psicoterapeuta)
        {
            try
            {
                var uow = new UnitOfWork();
                var psicoterapeutaEditar = uow.PsicoterapeutaRepository.GetSingle(psicoterapeuta.ID);
                psicoterapeutaEditar.Nombre = psicoterapeuta.Nombre;
                psicoterapeutaEditar.ApPaterno = psicoterapeuta.ApPaterno;
                psicoterapeutaEditar.ApMaterno = psicoterapeuta.ApMaterno;
                psicoterapeutaEditar.Telefono = psicoterapeuta.Telefono;
                psicoterapeutaEditar.Celular = psicoterapeuta.Celular;
                psicoterapeutaEditar.Whatsapp = psicoterapeuta.Whatsapp;
                psicoterapeutaEditar.IdTurno = psicoterapeuta.IdTurno;
                psicoterapeutaEditar.IdTipoCuota = psicoterapeuta.IdTipoCuota;
                psicoterapeutaEditar.Activo = psicoterapeuta.Activo;

                foreach (var tipoArea in psicoterapeutaEditar.PsicoterapeutasTiposAreas)
                    tipoArea.Activo = false;
                foreach (var tipoArea in psicoterapeuta.PsicoterapeutasTiposAreas)
                {
                    var existe = psicoterapeutaEditar.PsicoterapeutasTiposAreas.SingleOrDefault(ta => ta.IdTipoArea == tipoArea.IdTipoArea);
                    if (existe != null)
                        existe.Activo = true;
                    else
                        psicoterapeutaEditar.PsicoterapeutasTiposAreas.Add(new PsicoterapeutasTiposAreas{IdTipoArea = tipoArea.IdTipoArea, Activo = tipoArea.Activo});
                }

                foreach (var tipoPaciente in psicoterapeutaEditar.PsicoterapeutasTiposPacientes)
                    tipoPaciente.Activo = false;
                foreach (var tipoPaciente in psicoterapeuta.PsicoterapeutasTiposPacientes)
                {
                    var existe = psicoterapeutaEditar.PsicoterapeutasTiposPacientes.SingleOrDefault(ta => ta.IdTipoPaciente == tipoPaciente.IdTipoPaciente);
                    if (existe != null)
                        existe.Activo = true;
                    else
                        psicoterapeutaEditar.PsicoterapeutasTiposPacientes.Add(new PsicoterapeutasTiposPacientes { IdTipoPaciente = tipoPaciente.IdTipoPaciente, Activo = tipoPaciente.Activo });
                }

                foreach (var tipoTrastorno in psicoterapeutaEditar.PsicoterapeutasTiposTrastornos)
                    tipoTrastorno.Activo = false;
                foreach (var tipoTrastorno in psicoterapeuta.PsicoterapeutasTiposTrastornos)
                {
                    var existe = psicoterapeutaEditar.PsicoterapeutasTiposTrastornos.SingleOrDefault(ta => ta.IdTipoTrastorno == tipoTrastorno.IdTipoTrastorno);
                    if (existe != null)
                        existe.Activo = true;
                    else
                        psicoterapeutaEditar.PsicoterapeutasTiposTrastornos.Add(new PsicoterapeutasTiposTrastornos { IdTipoTrastorno = tipoTrastorno.IdTipoTrastorno, Activo = tipoTrastorno.Activo });
                }

                uow.PsicoterapeutaRepository.UpdateSingle(psicoterapeutaEditar);
                uow.Save();
            }
            catch (Exception ex)
            {
                Log.Error("[ System ] " + " [ Page ] " + "[ " + System.Reflection.MethodBase.GetCurrentMethod().DeclaringType.Name.ToString() + " ] [ " + System.Reflection.MethodBase.GetCurrentMethod().Name.ToString() + " ] [ Fin ]", ex);
                throw;
            }
        }
    }
}