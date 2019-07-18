# Repository Pattern: A data persistence abstraction

<hr/>

The Repository Pattern has gained quite a bit of popularity since it was first introduced as a part of [Domain-Driven-Design](http://bit.ly/PS-DDD) in 2004. Essentially, it provides an abstraction of data, so that application can work with a simple abstraction that has an interface approximating that of a collection. Adding, removing, updating, and selecting items from this collection is done through a series of straightforward methods, without the need to deal with database concerns like connections, commands, cursors, or readers. Using this pattern can help achieve loose coupling and can keep domain objects [persistence ignorant](http://deviq.com/persistence-ignorance/). Althogh the pattern is very popular (or perhaps because of this), it is also frewuently misunderstood and misused. Ther are many different ways to implement the Repository patter. Let's consider a few of them, and their merits and drawbacks.

## Repository Per Entity or Business Object

The simplest approach, especially with an existing system, is to create a new Repository implementation for each business object you need to store to or retreve from your persistence layer. Further, you should only implement the specifc methds you are calling in your application. Avoid the trap of creating a "standard" repository class, base class, or default interface that you must implement for all repositories. Yes, if you need to have an Update or a Delete method, you should strive to make its interface consisten, but don't implement a Delete method on your LokkupTableRepository that your're only ever going to be calling List() on. The biggest benefit of this approach is [YAGNI](http://deviq.com/yagni) - you won't waste any time implementing methods that never get called.

## Generic Repository Interface

```csharp
public interface IRepository<T> where T : EntityBase
{
    T GetById(int id);
    IEnumerable<T> List();
    IEnumerable<T> List(Expression<Func<T, bool>> predicate);
    void Add(T entity);
    void Delete(T entity);
    void Edit(T entity);
}

public abstract class EntityBase
{
   public int Id { get; protected set; }
}
```

Note that taking in a predicate elimicates the need to return an IQueryable, since any filter details can be passed into the repository. This can still lead to leaking of data access details into calling code through. Consider using the Specification pattern to alleviate this issue if you encounter it.

## Generic Repository Implementation

```csharp
public class Repository<T> : IRepository<T> where T : EntityBase
{
    private readonly ApplicationDbContext _dbContext;

    public Repository(ApplicationDbContext dbContext)
    {
        _dbContext = dbContext;
    }

    public virtual T GetById(int id)
    {
        return _dbContext.Set<T>().Find(id);
    }

    public virtual IEnumerable<T> List()
    {
        return _dbContext.Set<T>().AsEnumerable();
    }

    public virtual IEnumerable<T> List(System.Linq.Expressions.Expression<Func<T, bool>> predicate)
    {
        return _dbContext.Set<T>()
               .Where(predicate)
               .AsEnumerable();
    }

    public void Insert(T entity)
    {
        _dbContext.Set<T>().Add(entity);
        _dbContext.SaveChanges();
    }

    public void Update(T entity)
    {
        _dbContext.Entry(entity).State = EntityState.Modified;
        _dbContext.SaveChanges();
    }

    public void Delete(T entity)
    {
        _dbContext.Set<T>().Remove(entity);
        _dbContext.SaveChanges();
    }
}
```

Note that in this implementation, all operations are saved as they are performed; there is no Unit of Work being applied. There are a variety of ways in which Unit of Work behavior can be added to this implementation, the simplest of which being to add an explicit Save() method to the IRepository<T> method, and to only call the underlying SaveChanges() method from this method.

## IQueryable?

Another common question with Repositories has to do with what they return. SHould they return data, or should they return quries that can be further refined before execution (IQueryable)? The former is safer, but the latter offers a great deal of flexibility. In fact, you can simplify your interface to only offer a single method for reading data if you go the IQueryable route, since from there any number of items can be reutrned.

## Specification

Repositories that follow the advice of not exposing IQueryable can often become bloated with many custom query methods. The solution to this is to separate queries into their own types, using the [Specification Design Pattern](https://deviq.com/specification-pattern/). The Specification can include the expression used to filter the query, any parameters associated with this expression, as well as how much data the query should return. Combining the Repository and Specification patterns can be a great way to ensure you follow the [Single Repository Principle](https://deviq.com/single-responsibility-principle/) in your data access code.

<hr/>

Get more information at [here](https://deviq.com/repository-pattern/).
