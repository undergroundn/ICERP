using Model.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Repositories
{
    public class TutoresRepository : GenericRepository<IcerpEntities, Tutores>
    {
        public TutoresRepository()
        {
            Context = new IcerpEntities();
        }
        public TutoresRepository(IcerpEntities cEntities)
        {
            Context = cEntities;
        }
        public List<Tutores> Get()
        {
            var query = GetAll();
            return query.ToList();
        }

        public List<Tutores> GetBy(System.Linq.Expressions.Expression<Func<Tutores, bool>> predicate)
        {
            var query = FindBy(predicate);
            return query.ToList();
        }

        public Tutores GetSingle(int Id)
        {
            var query = Context.Tutores.FirstOrDefault(x => x.ID == Id);
            return query;
        }

        public void AddSingle(Tutores single)
        {
            Add(single);
        }

        public void UpdateSingle(Tutores single)
        {
            Edit(single);
        }
    }
}
