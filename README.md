# Data Scraping

Notes taken while trying to do some data scraping.

## Content

- [Script Snippets](#script-snippets)
- [Complext Scripts](#complex-scripts)
- [Tools](#tools)

## Script Snippets

- **JSON to CSV**
  **Only for flat JSONs*
  ```sh
  jq -r '(map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @csv'
  ```

- **JQ Mapping**
  ```sh
   jq '[.[] | {.newField1: .oldField1, .oldField2}]'
  ```

- **Full Text with ripgrep**
  ```sh
   jq -c '.[]' | rg --ignore-case $search_term | jq
  ```

- **JQ Select**
  ```sh
  jq '.[] | select(.fieldName == $term)
  ```

- **JQ Select OR**
  ```sh
  jq '.[] | select(.fieldName as $f1| any ($term1 == $f1 or $term2 == $f1))
  ```

## Complex Scripts

- [Paginated API](scripts/fetch.sh)
- [Combine JSONs](scripts/stich-together-jsons.sh)

## Tools

- [jq](https://jqlang.github.io/jq/manual/)
- [ripgrep](https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md)
