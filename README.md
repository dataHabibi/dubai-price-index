# Dubai residential price and rent index

A monthly price index for Dubai residential property, built from Dubai Land Department transaction records. Sales from January 2008, registered leases from May 2010, updated as new records land.

**1,080,194 sales across 223 months.**

![Dubai residential sale prices, 2008 to 2026](https://datahabibi.ae/api/og/price-index/figure)

Interactive version, with the rent index and a breakdown for 127 communities: [datahabibi.ae/dubai/intelligence/price-index](https://datahabibi.ae/dubai/intelligence/price-index)

## The data

| File | Rows | Covers |
|---|---|---|
| [`data/dubai-price-index-monthly.csv`](data/dubai-price-index-monthly.csv) | 223 | Sale prices, monthly from January 2008 |
| [`data/dubai-rent-index-monthly.csv`](data/dubai-rent-index-monthly.csv) | 195 | Registered lease rents, monthly from May 2010 |

Both are regenerated from the live endpoints:

```bash
curl -o data/dubai-price-index-monthly.csv \
  "https://datahabibi.ae/api/data/price-index.csv"

curl -o data/dubai-rent-index-monthly.csv \
  "https://datahabibi.ae/api/data/price-index.csv?series=rent"
```

## Columns

| Column | Meaning |
|---|---|
| `month` | `YYYY-MM` |
| `sales_count` | Transactions registered that month |
| `median_aed_per_sqft` | That month's own median, unsmoothed. Rent file: per year |
| `ma5_aed_per_sqft` | Five month centred average of the above |
| `index_base100` | `ma5` rebased to 100 at the first month of the series |
| `provisional` | `true` while the centred window is still open |

## Method

Each month's figure is the **median** price per square foot of the homes that actually sold, not the mean. One penthouse should not move a city.

Price **per square foot**, not price. A median sale price rises whenever buyers move to bigger homes, even if space costs exactly what it did last month. Dividing by area removes that.

The published line is a **five month centred average** of those monthly medians. Raw monthly medians in a market this size swing several percent on mix alone, so a single month's figure carries far less signal than it appears to.

The index is **rebased to 100** at the first month of each series, which is how house price indices are conventionally shown. Sale and rent therefore compare as change, never as level.

## Two things to know before you use this

**The last two months are provisional.** A centred average needs two months on either side. The final two rows have fewer than that, so their `ma5_aed_per_sqft` and `index_base100` will keep moving as later months arrive. Their `median_aed_per_sqft` and `sales_count` are unaffected. The `provisional` column marks them. Filter on it if you are quoting a headline figure.

**Recent `sales_count` values are understated.** Land Department registrations land one to two months after the deal closes, so the tail of that column is still filling in. A drop at the end of the series is a reporting lag, not a collapse in demand. Treat the last three months of volume as incomplete.

## What this is not

This is a **median price per square foot series, not a repeat sales or hedonic index.** It is not quality adjusted. Shifts in what sells, off plan against ready, apartment against villa, which communities are active in a given month, move this line without any individual property changing price. A year when Dubai delivers unusually good stock reads as a price rise here, because in the only sense the data can see, it is one.

It is also citywide. A tower in Downtown and a villa community on the edge of the city can move in opposite directions in the same month and neither shows up. For community level figures, see the [interactive breakdown](https://datahabibi.ae/dubai/intelligence/price-index).

## Source

Dubai Land Department residential transaction and lease records, which are public.

## Licence

[CC BY 4.0](LICENSE). Use it commercially, modify it, redistribute it. Please attribute.

```
dataHabibi, Dubai residential price index, derived from Dubai Land Department
transaction records. https://datahabibi.ae/dubai/intelligence/price-index
```

## Related

- [Dubai price index](https://datahabibi.ae/dubai/intelligence/price-index), the interactive chart, rent index and community breakdown
- [Dubai transactions](https://datahabibi.ae/dubai/intelligence/transactions/sale), every registered sale
- [Dubai mortgage rates](https://datahabibi.ae/mortgage-rates), Central Bank EIBOR fixings and current bank rates

Corrections and method arguments are welcome. Open an issue.
