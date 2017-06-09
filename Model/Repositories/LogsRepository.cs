using Model.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Repositories
{
    public class LogsRepository : GenericRepository<IcerpEntities, Logs>
    {
        public LogsRepository()
        {
            Context = new IcerpEntities();
        }
        public LogsRepository(IcerpEntities cEntities)
        {
            Context = cEntities;
        }
        public List<Logs> Get()
        {
            var query = GetAll();
            return query.ToList();
        }

        public List<Logs> GetBy(System.Linq.Expressions.Expression<Func<Logs, bool>> predicate)
        {
            var query = FindBy(predicate);
            return query.ToList();
        }

        public Logs GetSingle(int Id)
        {
            var query = Context.Logs.FirstOrDefault(x => x.ID == Id);
            return query;
        }

        public void AddSingle(Logs single)
        {
            Add(single);
        }

        public void UpdateSingle(Logs single)
        {
            Edit(single);
        }
    }
}
