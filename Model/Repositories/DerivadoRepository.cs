using Model.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Repositories
{
    public class DerivadoRepository: GenericRepository<IcerpEntities, Derivado>
    {
        public DerivadoRepository()
        {
            Context = new IcerpEntities();
        }
        public DerivadoRepository(IcerpEntities cEntities)
        {
            Context = cEntities;
        }
        public List<Derivado> Get()
        {
            var query = GetAll();
            return query.ToList();
        }

        public List<Derivado> GetBy(System.Linq.Expressions.Expression<Func<Derivado, bool>> predicate)
        {
            var query = FindBy(predicate);
            return query.ToList();
        }

        public Derivado GetSingle(int Id)
        {
            var query = Context.Derivado.FirstOrDefault(x => x.IdDerivado == Id);
            return query;
        }

        public void AddSingle(Derivado single)
        {
            Add(single);
        }

        public void UpdateSingle(Derivado single)
        {
            Edit(single);
        }
    }
}
