using Model.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Repositories
{
    public class TipoPagoRepository : GenericRepository<IcerpEntities, TipoPago>
    {
        public TipoPagoRepository()
        {
            Context = new IcerpEntities();
        }
        public TipoPagoRepository(IcerpEntities cEntities)
        {
            Context = cEntities;
        }
        public List<TipoPago> Get()
        {
            var query = GetAll();
            return query.ToList();
        }

        public List<TipoPago> GetBy(System.Linq.Expressions.Expression<Func<TipoPago, bool>> predicate)
        {
            var query = FindBy(predicate);
            return query.ToList();
        }

        public TipoPago GetSingle(int Id)
        {
            var query = Context.TipoPago.FirstOrDefault(x => x.ID == Id);
            return query;
        }

        public void AddSingle(TipoPago single)
        {
            Add(single);
        }

        public void UpdateSingle(TipoPago single)
        {
            Edit(single);
        }
    }
}
