using Model.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Repositories
{
    public class InformacionBienesESRepository : GenericRepository<IcerpEntities, InformacionBienesES>
    {
        public InformacionBienesESRepository()
        {
            Context = new IcerpEntities();
        }
        public InformacionBienesESRepository(IcerpEntities cEntities)
        {
            Context = cEntities;
        }
        public List<InformacionBienesES> Get()
        {
            var query = GetAll();
            return query.ToList();
        }

        public List<InformacionBienesES> GetBy(System.Linq.Expressions.Expression<Func<InformacionBienesES, bool>> predicate)
        {
            var query = FindBy(predicate);
            return query.ToList();
        }

        public InformacionBienesES GetSingle(int Id)
        {
            var query = Context.InformacionBienesES.FirstOrDefault(x => x.ID == Id);
            return query;
        }

        public void AddSingle(InformacionBienesES single)
        {
            Add(single);
        }

        public void UpdateSingle(InformacionBienesES single)
        {
            Edit(single);
        }
    }
}
