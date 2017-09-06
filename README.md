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
