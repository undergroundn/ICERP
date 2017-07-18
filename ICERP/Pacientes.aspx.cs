using Model.UnitOfWork;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ICERP
{
    public partial class Pacientes : System.Web.UI.Page
    {
        private static readonly LoggerUtility.ILogger Log = LoggerUtility.Logger.GetInstance();
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        //Obtener el listado de turnos para cargar la lista
        [WebMethod]
        public static string obtenerTurnos()
        {
            try
            {
                var uow = new UnitOfWork();
                var turnos = uow.TurnosRepository.Get().Where(x=>x.Activo == true).Select(tc => new { tc.ID, tc.Turno });
                return new JavaScriptSerializer().Serialize(turnos);
            }
            catch (Exception ex)
            {
                Log.Error("[ System ] " + " [ Page ] " + "[ " + System.Reflection.MethodBase.GetCurrentMethod().DeclaringType.Name.ToString() + " ] [ " + System.Reflection.MethodBase.GetCurrentMethod().Name.ToString() + " ] [ Fin ]", ex);
                throw;
            }
        }
        //Guardar los datos de un nuevo paciente
        [WebMethod]
        public static void guardarPaciente(Model.Pacientes paciente)
        {
            try
            {
                var uow = new UnitOfWork();
                var userId = Int32.Parse(HttpContext.Current.Session["userID"].ToString());
                paciente.IdUsuarioRegistro = userId;// Queries.GetCurrentUser().ID;
                paciente.FechaRegistro = DateTime.Now;
                uow.PacientesRepository.Add(paciente);
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