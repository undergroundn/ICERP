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
    
    public partial class Menu
    {
        public Menu()
        {
            this.Permisos = new HashSet<Permisos>();
            this.MenuUsuario = new HashSet<MenuUsuario>();
        }
    
        public int MenuId { get; set; }
        public string NombreMenu { get; set; }
        public string MenuUrl { get; set; }
        public Nullable<bool> Activo { get; set; }
        public Nullable<int> MenuPadreId { get; set; }
        public string Icono { get; set; }
        public Nullable<byte> Orden { get; set; }
    
        public virtual ICollection<Permisos> Permisos { get; set; }
        public virtual ICollection<MenuUsuario> MenuUsuario { get; set; }
    }
}
