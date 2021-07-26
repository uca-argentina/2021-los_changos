# Ingenieria del Software II - Template

![GHA Status](https://github.com/uca-is2/2021-los_changos/actions/workflows/GHA.yml/badge.svg)
[![Coverage Status](https://coveralls.io/repos/github/uca-is2/2021-los_changos/badge.svg?branch=master)](https://coveralls.io/github/uca-is2/2021-los_changos?branch=master)

## Metacello

```smalltalk
Metacello new
   baseline: 'IngSoft2';
   githubUser: 'uca-is2' project: '2021-los_changos' commitish: 'master' path: 'repository';
   load: 'development'.
```
