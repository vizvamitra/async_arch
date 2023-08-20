# Async Archetecture V Homework

## HW 1

Everything is in this [Miro board](https://miro.com/app/board/uXjVMyP5qFU=/)

## HW 3

### Adding new events

On event update, perform the following sequence of steps:

1. Add a schema for the new version to `schema_registry`, update `events` library and deploy.
2. Update consumers to support the new version of the event and deploy.
3. Update producers to produce the new version and deploy

### Handling errors

#### Event Ordering errors in accounting

In case when transaction-generating event occurs when we don't have some data yet, we usually have at least public_id of the missing record, which is used to create missing records (employee, account or task). This allows us to record the transaction and fill in the gaps in the data later

#### Message brocker failures

TODO: We should implement retries, i.e. put the event to some kind of a retry queue or implement a transactional outbox / log tailing.

#### Invalid events

TODO: We need to preserve those events and make the fact that they broke easy to spot. To do so, we should put them into the "dead events queue" or record into the database.
