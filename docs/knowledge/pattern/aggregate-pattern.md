# Aggregate Pattern

Aggregates are alla bout transactional consistency. When there is a strong consistency rule between multiple entities, we make one of them responsible for enforcing it.

<hr/>

## Problem

Imagine that you're writing yet another e-commerce appilcation and you're tasked with writing the all-important Order class:

```java

@Entity
public class Order {
    private String id;
    private Instant date;
    private List<OrderPosition> orderPositions;
    // stuff
}
@Entity
public class OrderPosition {
    private String id;
    private String name;
    private BigDecimal quantity;
    // stuff
}
```

Until the order is packed and ready to ship, customers are allowed to add a position to it:

```java
public class OrderService {
    // fields, c-tor
    public void addPosition(String orderId, String productId, BigDecimal quantity) {
        // stuff
    }
}
```

Now, the business has asked you to limit the possibility to order more than 100 hundred items or for more than $5,000. How do you ensure that these criteria are met, considering the fact that you're working in a concurrent environment and using a relational database?

## Aggregate Pattern

This is aclassic usage example of the fmous Aggregate Pattern. Although some try to identify aggregates by looking for matching domain concepts, the pattern's real purpose is to help you ensure transactional consistency and performing persistence operations just on this entity. We call such entity an aggregate root. Any other entities that are "ensured" consistent have to be saved in a single transaction by saving the aggregate root itself.

Applying this to our example, we could say the Order class should be an aggregate over OrderPosition class. This implies the following:

- The Order class is responsible for ensuring the maximum amount of postions and their maximum balance.
- The Order class requires some concurrency mechanism e.g. optimistic locking (AKA versioning).
- There will be an OrderRepository class in the system, but not an OrderPositionRepository class.
- The addPosition operation has to be performed in a transaction.

```java
@Entity
public class Order {
    private String id;
    private Long version; // optimistic locking!
    // other fields, c-tor
    public void addPosition(Product product, BigDecimal quantity) {
        if (hasMaxPositions()) {
            throw new TooManyPositionsException(id);
        }
        if (valueTooHigh(product.getPrice().times(quantity))) {
            throw new ValueTooHighException(id);
        }
        // stuff
    }
}
public class OrderService {
    // fields, c-tor
    @Transactional
    public void addPosition(String orderId, String productId, BigDecimal quantity) {
        Order order = orderRepository.findById(orderId);
        Product product = productRepository.findById(productId);
        order.addPosition(product, quantity);
        orderRepository.save(order);
    }
}
```

## One Aggregate Per transaction

There's a good rule for working with aggregates that says that **we should not update more than one aggregate per transaction**. It makes perect sense. Look, if I'm saying that consistency rules lie within the aggregate, then I should be able to save only this one, single aggregate - and everything should stay consistent. If that's not the case, maybe I'm missing an "uber-aggregate" on top of the two that I want to update in a single transaction. Or maybe these rules don't call for transactional consistency at all!

The rule of one aggregate per transaction has also a usability argument on its side. Imagine the following scenario:

If our users are trying to deal with the same aggregates at the same time, the risk of having a failed transaction grows. User 2 could prevent the tow other users from saving their work and, at the same time, any of the two other users could prevent user 3 from saving his or her work. That's not a desirable state of things. By limiting the transactions to one aggregate, we reduce the risk of failed concerrent transactions and therefore improve the usability of our application.

## Keep The Aggregates Small

The rule above and the way programmers think combine in a pretty strong force towards big aggregates. Let's say that someone added a status field to the Order class:

```java
public enum OrderStatus {
    UNPAID, PAID, IN_DELIVERY, COMPLETED
}
```

The business asks you to change the status to PAID once 99% of the order value is paid, to IN_DELIVERY once the guy at the warehouse starts to fill the parcels, and to COMPLETED once all parcels ae delivered. Does that mean that the Order class should now take care of payments, parcels, and trackng the guy at the warehouse? The resulting aggregate would be a giant class with lots of responsibilities, just for the sake of maintaining consistency. Also, performance would suffer badly and the risk of a failed transaction would grow significantly. That's a pretty extreme vision, but it shows the limits of the Aggregate pattern's applicability.

## Eventual Consistency

Things are usually not that bad. If you go and ask the business whether ist's okay for the order status to be updated a few seconds after the payment has been received or the parcel is delivered, they will most likely answer positively. Programmers often envision temporary lack of consistency as something evil and dangerous. That's a nerd point of view. When the business guys say consistent, they usually mean eventually consistent, and often, it could be even later than a few seconds.

**There fore, talk to the business guys and embrace eventual consistency, when the domain allows it, to keep your aggregates small and your code simple.**

<hr/>

Get more information at [here](https://dzone.com/articles/aggregate-pattern).