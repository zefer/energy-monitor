# Energy Monitor

A LightwaveRF Electricity Monitor broadcasts electricity usage over UDP on port
9761. This listens for it, decodes it, and sends the electricity to an InfluxDB
database so it can be plotted on a Grafana dashboard.

## Links

- [LightwaveRF Energy Monitor](https://lightwaverf.com/products/jsjslw600-lightwaverf-electricity-monitor-and-energy-monitor)
- [InfluxDB][https://influxdata.com/time-series-platform/influxdb/]
- [influxdb-ruby][https://github.com/influxdata/influxdb-ruby]
- [Grafana](https://grafana.com/)
