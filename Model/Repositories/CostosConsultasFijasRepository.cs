using Model.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Repositories
{
    public class CostosConsultasFijasRepository : GenericRepository<IcerpEntities, CostosConsultasFijas>
    {
        public CostosConsultasFijasRepository()
        {
            Context = new IcerpEntities();
        }
        public CostosConsultasFijasRepository(IcerpEntities cEntities)
        {
            Context = cEntities;
        }
        public List<CostosConsultasFijas> Get()
        {
            var query = GetAll();
            return query.ToList();
        }

        public List<CostosConsultasFijas> GetBy(System.Linq.Expressions.Expression<Func<CostosConsultasFijas, bool>> predicate)
        {
            var query = FindBy(predicate);
            return query.ToList();
        }

        public CostosConsultasFijas GetSingle(int Id)
        {
            var query = Context.CostosConsultasFijas.FirstOrDefault(x => x.ID == Id);
            return query;
        }

        public void AddSingle(CostosConsultasFijas single)
        {
            Add(single);
        }

        public void UpdateSingle(CostosConsultasFijas single)
        {
            Edit(single);
        }
    }
}
