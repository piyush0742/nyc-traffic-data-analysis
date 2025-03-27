CREATE TABLE cleaned_nyc_traffic 
WITH (
  format = 'Parquet',
  external_location = 's3-bucket-ARN/folder'
) AS
SELECT 
  requestid,
  boro,
  yr,
  m,
  d,
  hh,
  mm,
  CAST(
    CONCAT(
      CAST(yr AS VARCHAR), 
      '-', 
      LPAD(CAST(m AS VARCHAR), 2, '0'), 
      '-', 
      LPAD(CAST(d AS VARCHAR), 2, '0'),
      ' ', 
      LPAD(CAST(hh AS VARCHAR), 2, '0'), 
      ':', 
      LPAD(CAST(mm AS VARCHAR), 2, '0'),
      ':00'
    ) AS TIMESTAMP
  ) AS timestamp,
  TRY_CAST(vol AS INTEGER) AS traffic_volume,
  TRY_CAST(segmentid AS INTEGER) AS segmentid,
  wktgeom,
  street,
  fromst,
  tost,
  UPPER(TRIM(direction)) AS direction
FROM raw_data;
