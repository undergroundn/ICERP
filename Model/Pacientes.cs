//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Model
{
    using System;
    using System.Collections.Generic;
    
    public partial class Pacientes
    {
        public Pacientes()
        {
            this.Citas = new HashSet<Citas>();
            this.CobroConsulta = new HashSet<CobroConsulta>();
        }
    
        public int ID { get; set; }
        public string Nombre { get; set; }
        public string ApPaterno { get; set; }
        public string ApMaterno { get; set; }
        public Nullable<int> IdTutor { get; set; }
        public Nullable<int> Edad { get; set; }
        public string Motivo { get; set; }
        public string Horario { get; set; }
        public Nullable<short> IdTurno { get; set; }
        public string FechaNacimiento { get; set; }
        public string Genero { get; set; }
        public Nullable<int> Activo { get; set; }
        public string MedioDifusion { get; set; }
        public int IdUsuarioRegistro { get; set; }
        public System.DateTime FechaRegistro { get; set; }
    
        public virtual ICollection<Citas> Citas { get; set; }
        public virtual ICollection<CobroConsulta> CobroConsulta { get; set; }
        public virtual Turnos Turnos { get; set; }
        public virtual Tutores Tutores { get; set; }
    }
}
