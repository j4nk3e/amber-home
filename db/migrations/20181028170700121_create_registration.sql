-- +micrate Up
CREATE TABLE registration (
  id INTEGER NOT NULL PRIMARY KEY,
  created_at TIMESTAMP,
  updated_at TIMESTAMP,
  internal_id TEXT,
  address TEXT,
  username TEXT
);


-- +micrate Down
DROP TABLE IF EXISTS registrations;
