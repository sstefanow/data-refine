# ./jq

* [jq](https://github.com/stedolan/jq)

usuwame zbędne zagnieżdżenie:

```bash
cat UKGOV.json | jq -c '.rows[]' > ukgov.json
```
