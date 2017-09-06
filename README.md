# PlateSlate

## remove warning
```
$ atom lib/plate_slate_web/endpoint.ex
```
comment out line 4

## test setup
```
$ mkdir -p test/plate_slate_web/query/
$ touch test/plate_slate_web/query/menu_items_test.exs
```

## setup menu resolver
```
$ atom lib/plate_slate/menu/menu.ex
$ mkdir lib/plate_slate_web/resolvers
$ touch lib/plate_slate_web/resolvers/menu.ex
$ atom lib/plate_slate_web/resolvers/menu.ex
```

## setup ordering
```
mix phx.gen.schema Ordering.Item order_items order_id:references:orders menu_item_id:references:items price:decimal quantity:integer
mix phx.gen.schema Ordering.Item order_items order_id:references:orders menu_item_id:references:menu_items price:decimal quantity:integer
mix ecto.migrate
```
