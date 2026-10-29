DROP TABLE IF EXISTS user_behavior, behavior_daily_summary;

CREATE TABLE user_behavior (
  user_id     BIGINT      NOT NULL,
  item_id     BIGINT      NOT NULL,
  category_id BIGINT      NOT NULL,
  behavior    VARCHAR(10) NOT NULL,
  ts          BIGINT      NOT NULL,
  event_time  DATETIME    NOT NULL,
  dt          DATE        NOT NULL,
  KEY idx_ub_dt (dt)
);

CREATE TABLE behavior_daily_summary (
  dt       DATE        NOT NULL,
  behavior VARCHAR(10) NOT NULL,
  events   BIGINT      NOT NULL,
  PRIMARY KEY (dt, behavior)
);