using Model.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Repositories
{
    public class TipoCoutaRepository : GenericRepository<IcerpEntities, TipoCouta>
    {
        public TipoCoutaRepository()
        {
            Context = new IcerpEntities();
        }
        public TipoCoutaRepository(IcerpEntities cEntities)
        {
            Context = cEntities;
        }
        public List<TipoCouta> Get()
        {
            var query = GetAll();
            return query.ToList();
        }

        public List<TipoCouta> GetBy(System.Linq.Expressions.Expression<Func<TipoCouta, bool>> predicate)
        {
            var query = FindBy(predicate);
            return query.ToList();
        }

        public TipoCouta GetSingle(int Id)
        {
            var query = Context.TipoCouta.FirstOrDefault(x => x.ID == Id);
            return query;
        }

        public void AddSingle(TipoCouta single)
        {
            Add(single);
        }

        public void UpdateSingle(TipoCouta single)
        {
            Edit(single);
        }
    }
}
