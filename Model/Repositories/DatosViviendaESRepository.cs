using Model.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Repositories
{
    public class DatosViviendaESRepository: GenericRepository<IcerpEntities, DatosViviendaES>
    {
        public DatosViviendaESRepository()
        {
            Context = new IcerpEntities();
        }
        public DatosViviendaESRepository(IcerpEntities cEntities)
        {
            Context = cEntities;
        }
        public List<DatosViviendaES> Get()
        {
            var query = GetAll();
            return query.ToList();
        }

        public List<DatosViviendaES> GetBy(System.Linq.Expressions.Expression<Func<DatosViviendaES, bool>> predicate)
        {
            var query = FindBy(predicate);
            return query.ToList();
        }

        public DatosViviendaES GetSingle(int Id)
        {
            var query = Context.DatosViviendaES.FirstOrDefault(x => x.ID == Id);
            return query;
        }

        public void AddSingle(DatosViviendaES single)
        {
            Add(single);
        }

        public void UpdateSingle(DatosViviendaES single)
        {
            Edit(single);
        }
    }
}
