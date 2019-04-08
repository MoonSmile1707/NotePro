# Writing YAML

This document describes the most important features of YAML for use in CircleCI configuration.

- **[How to Write YAML](#how-to-write-yaml)** <br/>
- **[See Also](#see-also)**

## Overview

[YAML](https://yaml.org/) is a human-friendly data serialization standard for all programming languages. It is a strict superset of [JSON](https://www.json.org/), another data seralizationn languages. This means it can do everything JSON can.. and more.
Circle configuration is stored in a single YAML file located at `~/.circleci/config.yml`, where `~` is the root of your project;s directory. Since most of your work with CircleCI occures in this file, it is important to understand the basixs of YAML formatting.

## How to Write YAML

the basic structure of YAML file is a [hash map](https://en.wikipedia.org/wiki/Hash_table) and consists of one or more key-value pairs.

```YAML
key: value
```

you can set another key-value pair as a value by indenting the nested key.

```YAML
key:
    anothe_key: "another value"
```

### Multi-line Strings

if the value a multi-line string, use the `>` character, followed by any number of lines. this is especially useful for lengthy commends.

```YAML
haiku: >
    Consider me
    As one who loved poetry
    And persimmons.
```

<b>Note</b>: Quotes are not necessary when using multiline strings.

### Sequences

Keys and values are not restricted to [scalars](https://softwareengineering.stackexchange.com/questions/238033/what-does-it-mean-when-data-is-scalar). You may also map a scalar to a sequence.

```YAML
scalar:
    - never
    - gonna
    - give
    - you
    - up
```

Items in sequences can also be key-value pairs.

```YAML
simulation:
    - within: "a simulation"
    - without:
        a_glitch: "in the matrix"
```

<b>Note</b>: Remember to properly indent a key-value when it is the value of an item in a sequence.

### Achors and Aliases

To DRY up your `config.yml`, use anchors and aliases. Anchors are indentified by an `&` character, and aliases by an `*` character.

```YAML
song:
- &name Al
- You
- can
- call
- me
- *name
```

when the a bove list is read by a YAML parser, the literal oytput looks like this.

```YAML
song:
    - Al
    - You
    - can
    - call
    - me
    - Al
```

### Mergin Maps

Anchors and aliases work for scalar values, but to save maps or sequences, use `<<` to inject the alias.

```YAML
default: &default
    school: hogwarts

harry:
    <<: *default
    house: gryffindor
draco:
    <<: *default
    house: slytherin
```

You can also merge multi maps.

```YAML
name: &harray_name
    first_name: Harry
    last_name: Potter
address: &harry_address
    street: 4, Privet Drive
    district: Little Whinging
    county: Surrey
    country: England
harry_data:
    <<: [*harry_name, *harry_address]
```

<b>Note</b>: As mentioned in [a YAML repository issue](https://github.com/yaml/yaml/issues/35), it is possible to merge maps, but not sequences (also called arrays or lists).
for more complex example. see [this gist](https://gist.github.com/bowsersenior/979804).

## See Also

while YAML has several other feature, the examplws above should be enough to get you started with YAML and keep your CircleCI configuration concise. if you are hungry for moree knowledge, here a few ideas.

- For a concrete example of keys and values, see the [Configuring CircleCI](https://circleci.com/docs/2.0/configuration-reference/) document.
- If you are unsure whether your `config.yml` is value YAML, [run it through a validator](http://yaml-online-parser.appspot.com/).

CircleCI has also developed "orbs," which enable you to use pre-configured and tested packages of configuration elements that you can use in our cnfiguration workflow. Utilizing DRY (Don't Repeat Yourself), orbs enable you to quickly and easily incorporate configuration elements (jobs, executors, commands) in your workflow. For more detailed information about orb:

- Refer to [Orb introduction](https://circleci.com/docs/2.0/orb-intro/), for a high-level overview of orbs.
- Refer to [Using Orbs](https://circleci.com/docs/2.0/using-orbs/), for more about how to use existing orbs.
- Refer to [Creating Orbs](https://circleci.com/docs/2.0/creating-orbs/), where you will find step-by-step instructions on how to create your own orb.
- Refer to [Reusing Config](https://circleci.com/docs/2.0/reusing-config/) for more detailsed examples of reusable orbs, commands, parameters, and executors.
- For a more exhaustive overvire of YAML, LEarn X in Y Minutes has a great summary.
