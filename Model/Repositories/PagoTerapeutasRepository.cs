using Model.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Repositories
{
    public class PagoTerapeutasRepository : GenericRepository<IcerpEntities, PagoTerapeutas>
    {
        public PagoTerapeutasRepository()
        {
            Context = new IcerpEntities();
        }
        public PagoTerapeutasRepository(IcerpEntities cEntities)
        {
            Context = cEntities;
        }
        public List<PagoTerapeutas> Get()
        {
            var query = GetAll();
            return query.ToList();
        }

        public List<PagoTerapeutas> GetBy(System.Linq.Expressions.Expression<Func<PagoTerapeutas, bool>> predicate)
        {
            var query = FindBy(predicate);
            return query.ToList();
        }

        public PagoTerapeutas GetSingle(int Id)
        {
            var query = Context.PagoTerapeutas.FirstOrDefault(x => x.ID == Id);
            return query;
        }

        public void AddSingle(PagoTerapeutas single)
        {
            Add(single);
        }

        public void UpdateSingle(PagoTerapeutas single)
        {
            Edit(single);
        }
    }
}
