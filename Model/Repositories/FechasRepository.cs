using Model.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Repositories
{
    public class FechasRepository : GenericRepository<IcerpEntities, Fechas>
    {
        public FechasRepository()
        {
            Context = new IcerpEntities();
        }
        public FechasRepository(IcerpEntities cEntities)
        {
            Context = cEntities;
        }
        public List<Fechas> Get()
        {
            var query = GetAll();
            return query.ToList();
        }

        public List<Fechas> GetBy(System.Linq.Expressions.Expression<Func<Fechas, bool>> predicate)
        {
            var query = FindBy(predicate);
            return query.ToList();
        }

        public Fechas GetSingle(int Id)
        {
            var query = Context.Fechas.FirstOrDefault(x => x.ID == Id);
            return query;
        }

        public void AddSingle(Fechas single)
        {
            Add(single);
        }

        public void UpdateSingle(Fechas single)
        {
            Edit(single);
        }
    }
}
