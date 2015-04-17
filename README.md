# confucius
Simple framework-agnostic configuration for any Ruby app.

Confucius intends to provide dead simple, no dependencies, framework-agnostic
library for loading config files and storing settings. It wants to be
simple, minimal magic, maximal flexibility and usability thing.

As of version 0.0.1 (aka Not Relased Yet) it is just a small piece of code,
extracted from other project.

## Usage

Assuming you have `config/myconfig.yml`:

```yaml
db:
  adapter: mysql2
  database: mydb
  user: ...
logs:
  path: log
  level: info
```

Just load config into any class or module you want:

```ruby
class MyClass
  extend Confucius
end

MyClass.from_yaml('config/something.yml')

# And here you are:

MyClass.settings.db
# => {'adapter' => 'mysql', 'database' => 'mydb'}

MyClass.settings.logs
# => {'path' => 'log', 'level' => 'info'}
```

NB: Confucius is smart enough to check, if class it's extended with
alread has `#settings` method, so, you potentiall can use it with, say,
Sinatra app and everything will work fine.

But what if you want not only load config, but initalize something with it,
like DB connections? Confucius already can help you:

```ruby
class MyClass
  extend Confucius

  setup(:db){|config|
    Sequel.connect(config)
  }
end

MyClass.from_yaml('config/something.yml')

MyClass.settings.db
# => Sequel::Connection

MyClass.settings.db_config
# => {'adapter' => 'mysql', 'database' => 'mydb'}
```

Neat.

And even more goodness:

```ruby
class MyClass
  extend Confucius

  setup(:db){|config|
    Sequel.connect(config)
  }.then{|db|
    # you can perform some after-connect operations with the object
    Sequel::Model.database = db
  }
end
```

That's all for now, everything else are dreams.

## TODO

* support for environments (`"dev", "prod"` and so on,
  flexible like in sinatra-config)
* load from multiple files at once
* load not only from YAML
* support for settings validation (required, optional, default settings)
  * and therefore, support for sample config generation
* check, if it really plays well with Sinatra, Grape, Thor and so on
* tests, code cleanup, docs ...

The code is one day old (when I write it 2015/04/17), do not expect much.
