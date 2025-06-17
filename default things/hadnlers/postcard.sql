DROP TABLE IF EXISTS penguin_special_postcard;
DROP TABLE IF EXISTS special_postcard;

CREATE TABLE special_postcard (
  id INT NOT NULL,
  postcard_id SMALLINT NOT NULL,
  start_date TIMESTAMP NOT NULL,
  end_date TIMESTAMP NOT NULL,
  sender_id INT DEFAULT NULL, -- NULL is sys
  PRIMARY KEY (id),
  CONSTRAINT special_postcard_ibfk_1 FOREIGN KEY (postcard_id) REFERENCES postcard (id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT penguin_postcard_ibfk_2 FOREIGN KEY (sender_id) REFERENCES penguin (id) ON DELETE CASCADE ON UPDATE CASCADE
);

COMMENT ON TABLE special_postcard IS 'Special postcard';

COMMENT ON COLUMN special_postcard.id IS 'Unique special postcard ID';
COMMENT ON COLUMN special_postcard.postcard_id IS 'Postcard type ID';
COMMENT ON COLUMN special_postcard.start_date IS 'Sending start timestamp';
COMMENT ON COLUMN special_postcard.end_date IS 'Sending end timestamp';
COMMENT ON COLUMN special_postcard.sender_id IS 'Sender penguin ID';

INSERT INTO special_postcard (id, postcard_id, start_date, end_date, sender_id) VALUES
 (1, 181, now(), '2023-4-30 23:59:59', 1); -- Placeholder timestamps; sender_id 1 is Rockhopper


-- I will just do this like items because it's easier
CREATE TABLE penguin_special_postcard (
  penguin_id INT NOT NULL,
  special_postcard_id INT NOT NULL,
  PRIMARY KEY (penguin_id, special_postcard_id),
  CONSTRAINT penguin_special_postcard_ibfk_1 FOREIGN KEY (penguin_id) REFERENCES penguin (id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT penguin_special_postcard_ibfk_2 FOREIGN KEY (special_postcard_id) REFERENCES special_postcard (id) ON DELETE CASCADE ON UPDATE CASCADE
);

COMMENT ON TABLE penguin_special_postcard IS 'Penguin received special postcards';

COMMENT ON COLUMN penguin_special_postcard.penguin_id IS 'Recipient penguin ID';
COMMENT ON COLUMN penguin_special_postcard.special_postcard_id IS 'Special postcard ID';