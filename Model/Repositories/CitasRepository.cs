using Model.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Repositories
{
    public class CitasRepository: GenericRepository<IcerpEntities, Citas>
    {
        public CitasRepository()
        {
            Context = new IcerpEntities();
        }
        public CitasRepository(IcerpEntities cEntities)
        {
            Context = cEntities;
        }
        public List<Citas> Get()
        {
            var query = GetAll();
            return query.ToList();
        }

        public List<Citas> GetBy(System.Linq.Expressions.Expression<Func<Citas, bool>> predicate)
        {
            var query = FindBy(predicate);
            return query.ToList();
        }

        public Citas GetSingle(int Id)
        {
            var query = Context.Citas.FirstOrDefault(x => x.ID == Id);
            return query;
        }

        public void AddSingle(Citas single)
        {
            Add(single);
        }

        public void UpdateSingle(Citas single)
        {
            Edit(single);
        }
    }
}
