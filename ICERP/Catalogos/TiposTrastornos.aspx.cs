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
    public partial class TiposTrastornos : System.Web.UI.Page
    {
        private static readonly LoggerUtility.ILogger Log = LoggerUtility.Logger.GetInstance();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string obtenerTiposTrastornos()
        {
            try
            {
                var uow = new UnitOfWork();
                var tiposTrastornos = uow.TipoTrastornoRepository.Get();
                var usuarios = uow.UsuariosRepository.Get();
                var consulta = from tt in tiposTrastornos
                               join u in usuarios on tt.IdUsuario equals u.ID
                               select new { tt.ID, tt.Tipo, NombreUsuario = u.Nombres + " " + u.ApPaterno + " " + u.ApMaterno, FechaAlta = tt.FechaAlta.ToString("dd/MM/yyyy"), Activo = tt.Activo ? "Si" : "No" };
                return new JavaScriptSerializer().Serialize(consulta);
            }
            catch (Exception ex)
            {
                Log.Error("[ System ] " + " [ Page ] " + "[ " + System.Reflection.MethodBase.GetCurrentMethod().DeclaringType.Name.ToString() + " ] [ " + System.Reflection.MethodBase.GetCurrentMethod().Name.ToString() + " ] [ Fin ]", ex);
                throw;
            }
        }

        //Guardar los datos de un nuevo tipo de trastorno
        [WebMethod]
        public static void guardarTipoTrastorno(Model.TipoTrastorno tipoTrastorno)
        {
            try
            {
                var uow = new UnitOfWork();
                tipoTrastorno.IdUsuario = Queries.GetCurrentUser().ID;
                tipoTrastorno.FechaAlta = DateTime.Now;
                uow.TipoTrastornoRepository.Add(tipoTrastorno);
                uow.Save();
            }
            catch (Exception ex)
            {
                Log.Error("[ System ] " + " [ Page ] " + "[ " + System.Reflection.MethodBase.GetCurrentMethod().DeclaringType.Name.ToString() + " ] [ " + System.Reflection.MethodBase.GetCurrentMethod().Name.ToString() + " ] [ Fin ]", ex);
                throw;
            }
        }

        //Obtener información del tipo de trastorno a editar
        [WebMethod]
        public static string obtenerDatosTipoTrastorno(short idTipoTrastorno)
        {
            try
            {
                var uow = new UnitOfWork();
                var tipoTrastorno = uow.TipoTrastornoRepository.GetSingle(idTipoTrastorno);
                var resultado = new { tipoTrastorno.ID, tipoTrastorno.Tipo, tipoTrastorno.Activo };
                return new JavaScriptSerializer().Serialize(resultado);
            }
            catch (Exception ex)
            {
                Log.Error("[ System ] " + " [ Page ] " + "[ " + System.Reflection.MethodBase.GetCurrentMethod().DeclaringType.Name.ToString() + " ] [ " + System.Reflection.MethodBase.GetCurrentMethod().Name.ToString() + " ] [ Fin ]", ex);
                throw;
            }
        }

        //Actualizar los datos de un tipo de trastorno
        [WebMethod]
        public static void actualizarTipoTrastorno(Model.TipoTrastorno tipoTrastorno)
        {
            try
            {
                var uow = new UnitOfWork();
                var tipoTrastornoEditar = uow.TipoTrastornoRepository.GetSingle(tipoTrastorno.ID);
                tipoTrastornoEditar.Tipo = tipoTrastorno.Tipo;
                tipoTrastornoEditar.Activo = tipoTrastorno.Activo;
                uow.TipoTrastornoRepository.UpdateSingle(tipoTrastornoEditar);
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