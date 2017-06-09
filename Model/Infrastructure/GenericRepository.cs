using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Infrastructure
{
    public abstract class GenericRepository<TC, T> :
        IGenericRepository<T>
        where T : class
        where TC : DbContext, new()
    {
        private TC _entities; // = new TC();

        public TC Context
        {

            get { return _entities; }
            set { _entities = value; }
        }

        public virtual IQueryable<T> GetAll()
        {

            IQueryable<T> query = _entities.Set<T>();
            return query;
        }

        public virtual IQueryable<T> GetInclude(string includeProperties = "")
        {

            IQueryable<T> query = _entities.Set<T>();
            query.Include(includeProperties);
            return query;
        }

        public IQueryable<T> FindBy(System.Linq.Expressions.Expression<Func<T, bool>> predicate)
        {

            IQueryable<T> query = _entities.Set<T>().Where(predicate);
            return query;
        }

        public virtual void Add(T entity)
        {
            _entities.Set<T>().Add(entity);
        }

        public virtual void Delete(T entity)
        {
            _entities.Set<T>().Remove(entity);
        }

        public virtual void Edit(T entity)
        {
            _entities.Entry(entity).State = System.Data.Entity.EntityState.Modified;
        }

        public virtual void Update(T entity, long key)
        {
            T existing = _entities.Set<T>().Find(key);
            if (existing != null)
            {
                _entities.Entry(existing).CurrentValues.SetValues(entity);

            }
        }

        public virtual void UpdatebyList(T entity, List<long> keys)
        {

            try
            {
                T existing = _entities.Set<T>().Find(keys);
                if (existing != null)
                {
                    _entities.Entry(existing).CurrentValues.SetValues(entity);

                }
            }
            catch (System.Data.Entity.Validation.DbEntityValidationException dbEx)
            {
                throw;
            }
        }

        public virtual void Update(T entity, int key)
        {
            T existing = _entities.Set<T>().Find(key);
            if (existing != null)
            {
                _entities.Entry(existing).CurrentValues.SetValues(entity);
            }
        }

        public virtual void Update(T entity, object key)
        {
            T existing = _entities.Set<T>().Find(key);
            if (existing != null)
            {
                _entities.Entry(existing).CurrentValues.SetValues(entity);
            }
        }


        public virtual void Attach(T entity)
        {
            _entities.Set<T>().Attach(entity);
            _entities.Entry(entity).State = System.Data.Entity.EntityState.Modified;
        }

        public virtual void Save()
        {
            try
            {
                _entities.SaveChanges();
            }
            catch (System.Data.Entity.Validation.DbEntityValidationException dbEx)
            {
                throw;
            }
        }

        public void RemoveAll(List<T> list)
        {
            _entities.Set<T>().RemoveRange(list);
        }

        public void AddList(List<T> list)
        {
            _entities.Set<T>().AddRange(list);
        }
    }
}
