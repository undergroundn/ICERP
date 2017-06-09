using Model.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Repositories
{
    public class DiasRepository : GenericRepository<IcerpEntities, Dias>
    {
        public DiasRepository()
        {
            Context = new IcerpEntities();
        }
        public DiasRepository(IcerpEntities cEntities)
        {
            Context = cEntities;
        }
        public List<Dias> Get()
        {
            var query = GetAll();
            return query.ToList();
        }

        public List<Dias> GetBy(System.Linq.Expressions.Expression<Func<Dias, bool>> predicate)
        {
            var query = FindBy(predicate);
            return query.ToList();
        }

        public Dias GetSingle(int Id)
        {
            var query = Context.Dias.FirstOrDefault(x => x.ID == Id);
            return query;
        }

        public void AddSingle(Dias single)
        {
            Add(single);
        }

        public void UpdateSingle(Dias single)
        {
            Edit(single);
        }
    }
}
