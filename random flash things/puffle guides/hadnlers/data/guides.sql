DROP TABLE IF EXISTS puffle_guide;
CREATE TABLE puffle_guide (
  id SERIAL,
  type VARCHAR(5) NOT NULL DEFAULT 'icon',
  item_id INT NOT NULL DEFAULT 7222,
  PRIMARY KEY (id)
);

COMMENT ON TABLE puffle_guide IS 'Server Puffle Guides rewards crumbs';

COMMENT ON COLUMN puffle_guide.id IS 'Reward ordering ID';
COMMENT ON COLUMN puffle_guide.type IS 'Reward type';
COMMENT ON COLUMN puffle_guide.item_id IS 'Reward item id/coin amount';

DROP TABLE IF EXISTS penguin_puffle_guide;
CREATE TABLE penguin_puffle_guide (
  penguin_id INT NOT NULL,
  guide_id INT NOT NULL DEFAULT 1,
  unlock_date TIMESTAMP NOT NULL,
  room_id INT NOT NULL DEFAULT 750,
  puffle_id INT NOT NULL DEFAULT 0,
  in_progress BOOLEAN NOT NULL DEFAULT FALSE,
  complete BOOLEAN NOT NULL DEFAULT FALSE,
  PRIMARY KEY (penguin_id),
  CONSTRAINT penguin_puffle_guide_ibfk_1 FOREIGN KEY (penguin_id) REFERENCES penguin (id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT penguin_puffle_guide_ibfk_2 FOREIGN KEY (guide_id) REFERENCES puffle_guide (id) ON DELETE SET DEFAULT ON UPDATE CASCADE,
  CONSTRAINT penguin_puffle_guide_ibfk_3 FOREIGN KEY (room_id) REFERENCES room (id) ON DELETE SET DEFAULT ON UPDATE CASCADE
);

ALTER TABLE penguin_puffle_guide ALTER COLUMN unlock_date SET DEFAULT now();

COMMENT ON TABLE penguin_puffle_guide IS 'Penguin Puffle Guides data';

COMMENT ON COLUMN penguin_puffle_guide.penguin_id IS 'Puffle Guides penguin ID';
COMMENT ON COLUMN penguin_puffle_guide.guide_id IS 'Puffle Guides reward ID';
COMMENT ON COLUMN penguin_puffle_guide.unlock_date IS 'Next available date';
COMMENT ON COLUMN penguin_puffle_guide.room_id IS 'Next room ID';
COMMENT ON COLUMN penguin_puffle_guide.puffle_id IS 'Next puffle ID';
COMMENT ON COLUMN penguin_puffle_guide.in_progress IS 'Task started?';
COMMENT ON COLUMN penguin_puffle_guide.complete IS 'Task complete?';

INSERT INTO room (id, name, member, max_users, required_item, game, blackhole, spawn, stamp_group, solo) VALUES
 (750, 'Wilds 1', FALSE, 800, NULL, FALSE, FALSE, FALSE, NULL, TRUE),
 (751, 'Wilds 2', FALSE, 800, NULL, FALSE, FALSE, FALSE, NULL, TRUE),
 (752, 'Wilds 3', FALSE, 800, NULL, FALSE, FALSE, FALSE, NULL, TRUE);