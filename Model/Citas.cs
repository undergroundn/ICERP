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
    
    public partial class Citas
    {
        public Citas()
        {
            this.CobroConsulta = new HashSet<CobroConsulta>();
        }
    
        public int ID { get; set; }
        public Nullable<int> IdConsultorio { get; set; }
        public Nullable<int> IdEstatus { get; set; }
        public int IdPaciente { get; set; }
        public decimal Cuota { get; set; }
        public Nullable<decimal> PagoTerapeuta { get; set; }
        public Nullable<System.DateTime> Fecha { get; set; }
        public int IdTerapeuta { get; set; }
        public Nullable<int> NumSesion { get; set; }
    
        public virtual Consultorios Consultorios { get; set; }
        public virtual EstatusCitas EstatusCitas { get; set; }
        public virtual Pacientes Pacientes { get; set; }
        public virtual Psicoterapeuta Psicoterapeuta { get; set; }
        public virtual ICollection<CobroConsulta> CobroConsulta { get; set; }
    }
}
