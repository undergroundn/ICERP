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
    
    public partial class EstatusCitas
    {
        public EstatusCitas()
        {
            this.Citas = new HashSet<Citas>();
        }
    
        public int ID { get; set; }
        public string Estatus { get; set; }
        public bool Activo { get; set; }
    
        public virtual ICollection<Citas> Citas { get; set; }
    }
}
