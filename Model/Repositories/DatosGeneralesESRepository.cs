using Model.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Repositories
{
    public class DatosGeneralesESRepository: GenericRepository<IcerpEntities, DatosGeneralesES>
    {
        public DatosGeneralesESRepository()
        {
            Context = new IcerpEntities();
        }
        public DatosGeneralesESRepository(IcerpEntities cEntities)
        {
            Context = cEntities;
        }
        public List<DatosGeneralesES> Get()
        {
            var query = GetAll();
            return query.ToList();
        }

        public List<DatosGeneralesES> GetBy(System.Linq.Expressions.Expression<Func<DatosGeneralesES, bool>> predicate)
        {
            var query = FindBy(predicate);
            return query.ToList();
        }

        public DatosGeneralesES GetSingle(int Id)
        {
            var query = Context.DatosGeneralesES.FirstOrDefault(x => x.ID == Id);
            return query;
        }

        public void AddSingle(DatosGeneralesES single)
        {
            Add(single);
        }

        public void UpdateSingle(DatosGeneralesES single)
        {
            Edit(single);
        }
    }
}
