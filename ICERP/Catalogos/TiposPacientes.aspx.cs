using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using ICERP.Utilities;
using Model.UnitOfWork;

namespace ICERP.Catalogos
{
    public partial class TiposPacientes : System.Web.UI.Page
    {
        private static readonly LoggerUtility.ILogger Log = LoggerUtility.Logger.GetInstance();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string obtenerTiposPacientes()
        {
            try
            {
                var uow = new UnitOfWork();
                var tiposPacientes = uow.TipoPacienteRepository.Get();
                var usuarios = uow.UsuariosRepository.Get();
                var consulta = from tp in tiposPacientes
                               join u in usuarios on tp.IdUsuario equals u.ID
                               select new { tp.ID, tp.Tipo, NombreUsuario = u.Nombres + " " + u.ApPaterno + " " + u.ApMaterno, FechaAlta = tp.FechaAlta.ToString("dd/MM/yyyy"), Activo = tp.Activo ? "Si" : "No" };
                return new JavaScriptSerializer().Serialize(consulta);
            }
            catch (Exception ex)
            {
                Log.Error("[ System ] " + " [ Page ] " + "[ " + System.Reflection.MethodBase.GetCurrentMethod().DeclaringType.Name.ToString() + " ] [ " + System.Reflection.MethodBase.GetCurrentMethod().Name.ToString() + " ] [ Fin ]", ex);
                throw;
            }
        }

        //Guardar los datos de un nuevo tipo de paciente
        [WebMethod]
        public static void guardarTipoPaciente(Model.TipoPaciente tipoPaciente)
        {
            try
            {
                var uow = new UnitOfWork();
                tipoPaciente.IdUsuario = Queries.GetCurrentUser().ID;
                tipoPaciente.FechaAlta = DateTime.Now;
                uow.TipoPacienteRepository.Add(tipoPaciente);
                uow.Save();
            }
            catch (Exception ex)
            {
                Log.Error("[ System ] " + " [ Page ] " + "[ " + System.Reflection.MethodBase.GetCurrentMethod().DeclaringType.Name.ToString() + " ] [ " + System.Reflection.MethodBase.GetCurrentMethod().Name.ToString() + " ] [ Fin ]", ex);
                throw;
            }
        }

        //Obtener información del tipo de paciente a editar
        [WebMethod]
        public static string obtenerDatosTipoPaciente(int idTipoPaciente)
        {
            try
            {
                var uow = new UnitOfWork();
                var tipoPaciente = uow.TipoPacienteRepository.GetSingle(idTipoPaciente);
                var resultado = new { tipoPaciente.ID, tipoPaciente.Tipo, tipoPaciente.Activo };
                return new JavaScriptSerializer().Serialize(resultado);
            }
            catch (Exception ex)
            {
                Log.Error("[ System ] " + " [ Page ] " + "[ " + System.Reflection.MethodBase.GetCurrentMethod().DeclaringType.Name.ToString() + " ] [ " + System.Reflection.MethodBase.GetCurrentMethod().Name.ToString() + " ] [ Fin ]", ex);
                throw;
            }
        }

        //Actualizar los datos de un tipo de paciente
        [WebMethod]
        public static void actualizarTipoPaciente(Model.TipoConsultorio tipoPaciente)
        {
            try
            {
                var uow = new UnitOfWork();
                var tipoPacienteEditar = uow.TipoPacienteRepository.GetSingle(tipoPaciente.ID);
                tipoPacienteEditar.Tipo = tipoPaciente.Tipo;
                tipoPacienteEditar.Activo = tipoPaciente.Activo;
                uow.TipoPacienteRepository.UpdateSingle(tipoPacienteEditar);
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