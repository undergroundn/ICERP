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
        [WebMethod]
        public static string obtenerPacientes()
        {
            try
            {
                var uow = new UnitOfWork();
                var pacientes = uow.PacientesRepository.Get().Select(c => new { c.ID, Nombre = c.Nombre +" "+ c.ApPaterno + " " +c.ApMaterno, c.Edad,c.Motivo,c.Horario,Tutor = c.Tutores.Nombre,c.Tutores.Telefono,c.Tutores.ViaContacto, Activo = c.Activo ? "Si" : "No" });
                return new JavaScriptSerializer().Serialize(pacientes);
            }
            catch (Exception ex)
            {
                Log.Error("[ System ] " + " [ Page ] " + "[ " + System.Reflection.MethodBase.GetCurrentMethod().DeclaringType.Name.ToString() + " ] [ " + System.Reflection.MethodBase.GetCurrentMethod().Name.ToString() + " ] [ Fin ]", ex);
                throw;
            }
        }
        //Guardar los datos de un nuevo paciente
        [WebMethod]
        //public static void guardarPaciente(Model.Pacientes paciente)
        public static void guardarPaciente(string nombre,string apPaterno,string apMaterno,string fechaNacimiento,string Edad,
            string genero,string Horario,string turnoid,string Motivo,string MedioDifusion,bool activo,string NombreTutor,string TelefonoTutor,string ViaContactoTutor,string ParentezcoTutor)
        {
            try
            {
                var uow = new UnitOfWork();
                Model.Pacientes paciente = new Model.Pacientes();
                var userId = Int32.Parse(HttpContext.Current.Session["userID"].ToString());
                paciente.Nombre = nombre;
                paciente.ApPaterno = apPaterno;
                paciente.ApMaterno = apMaterno;
                paciente.FechaNacimiento = fechaNacimiento;
                paciente.Edad = Edad != "" ? Convert.ToInt32(Edad): 0;
                paciente.Genero = genero;
                paciente.Horario = Horario;
                paciente.IdTurno = turnoid != "" ? Convert.ToInt16(turnoid) : (short?)null;
                paciente.Motivo = Motivo;
                paciente.MedioDifusion = MedioDifusion;
                paciente.Activo = activo;                
                paciente.IdUsuarioRegistro = userId;// Queries.GetCurrentUser().ID;
                paciente.FechaRegistro = DateTime.Now;
               
                Model.Tutores Tutores = new Model.Tutores();
                Tutores.Nombre = NombreTutor;
                Tutores.Telefono = TelefonoTutor;
                Tutores.ViaContacto = ViaContactoTutor;
                Tutores.Parentezco = ParentezcoTutor;
                //pendiente guardar tutores
                uow.TutoresRepository.Add(Tutores);
                paciente.IdTutor = Tutores.ID;
                uow.PacientesRepository.Add(paciente);
                uow.Save();
            }
            catch (Exception ex)
            {
                Log.Error("[ System ] " + " [ Page ] " + "[ " + System.Reflection.MethodBase.GetCurrentMethod().DeclaringType.Name.ToString() + " ] [ " + System.Reflection.MethodBase.GetCurrentMethod().Name.ToString() + " ] [ Fin ]", ex);
                throw;
            }
        }
        //Actualizar los datos de un paciente
        [WebMethod]
        public static void actualizarPaciente(int idPaciente, string nombre, string apPaterno, string apMaterno, string fechaNacimiento, string Edad,
            string genero, string Horario, string turnoid, string Motivo, string MedioDifusion, bool activo, string NombreTutor, string TelefonoTutor, string ViaContactoTutor, string ParentezcoTutor)
        {
            try
            {
                var uow = new UnitOfWork();
                var paciente = uow.PacientesRepository.GetSingle(idPaciente);                
                var userId = Int32.Parse(HttpContext.Current.Session["userID"].ToString());
                paciente.Nombre = nombre;
                paciente.ApPaterno = apPaterno;
                paciente.ApMaterno = apMaterno;
                paciente.FechaNacimiento = fechaNacimiento;
                paciente.Edad = Edad != "" ? Convert.ToInt32(Edad) : 0;
                paciente.Genero = genero;
                paciente.Horario = Horario;
                paciente.IdTurno = turnoid != "" ? Convert.ToInt16(turnoid) : (short?)null;
                paciente.Motivo = Motivo;
                paciente.MedioDifusion = MedioDifusion;
                paciente.Activo = activo;
                paciente.IdUsuarioRegistro = userId;// Queries.GetCurrentUser().ID;
                paciente.FechaRegistro = DateTime.Now;
                var idtutor = paciente.IdTutor != null ? Int32.Parse(paciente.IdTutor.ToString()) : 0;
                var Tutores = uow.TutoresRepository.GetSingle(idtutor);
                Tutores.Nombre = NombreTutor;
                Tutores.Telefono = TelefonoTutor;
                Tutores.ViaContacto = ViaContactoTutor;
                Tutores.Parentezco = ParentezcoTutor;
                //pendiente guardar tutores
                uow.TutoresRepository.UpdateSingle(Tutores);
                paciente.IdTutor = Tutores.ID;
                uow.PacientesRepository.UpdateSingle(paciente);
                uow.Save();
            }
            catch (Exception ex)
            {
                Log.Error("[ System ] " + " [ Page ] " + "[ " + System.Reflection.MethodBase.GetCurrentMethod().DeclaringType.Name.ToString() + " ] [ " + System.Reflection.MethodBase.GetCurrentMethod().Name.ToString() + " ] [ Fin ]", ex);
                throw;
            }
        }
        //Obtener información del consultorio a editar
        [WebMethod]
        public static string obtenerDatosPaciente(int IdPaciente)
        {
            try
            {
                var uow = new UnitOfWork();
                var paciente = uow.PacientesRepository.GetSingle(IdPaciente);
                var resultado = new { paciente.ID, paciente.Nombre,                      
                paciente.ApPaterno,
                paciente.ApMaterno,
                paciente.FechaNacimiento,
                paciente.Edad,
                paciente.Genero,
                paciente.Horario,
                paciente.IdTurno,
                paciente.Motivo,
                paciente.MedioDifusion,
                paciente.Activo,
                Tutor = paciente.Tutores.Nombre,
                telefono = paciente.Tutores.Telefono,
                viaContacto = paciente.Tutores.ViaContacto,
                Parentezco = paciente.Tutores.Parentezco, };
                return new JavaScriptSerializer().Serialize(resultado);
            }
            catch (Exception ex)
            {
                Log.Error("[ System ] " + " [ Page ] " + "[ " + System.Reflection.MethodBase.GetCurrentMethod().DeclaringType.Name.ToString() + " ] [ " + System.Reflection.MethodBase.GetCurrentMethod().Name.ToString() + " ] [ Fin ]", ex);
                throw;
            }
        }
    }
}