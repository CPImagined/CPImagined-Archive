from houdini.data import AbstractDataCollection, db

class PuffleGuide(db.Model):
    __tablename__ = 'puffle_guide' 

    id = db.Column(db.Integer, nullable=False, primary_key=True, server_default=db.text("nextval('\"penguin_id_seq\"'::regclass)"))
    type = db.Column(db.String(5), nullable=False, server_default=db.text("coins"))
    item_id = db.Column(db.ForeignKey('penguin.id', ondelete='SET DEFAULT', onupdate='CASCADE'), nullable=False, primary_key=True)


class PenguinPuffleGuide(db.Model):
    __tablename__ = 'penguin_puffle_guide' 

    penguin_id = db.Column(db.ForeignKey('penguin.id', ondelete='CASCADE', onupdate='CASCADE'), nullable=False, primary_key=True)
    guide_id = db.Column(db.ForeignKey('penguin.id', ondelete='SET DEFAULT', onupdate='CASCADE'), nullable=False, server_default=db.text("1"))
    unlock_date = db.Column(db.DateTime, nullable=False, server_default=db.text("now()"))
    room_id = db.Column(db.ForeignKey('penguin.id', ondelete='SET DEFAULT', onupdate='CASCADE'), nullable=False, server_default=db.text("750"))
    puffle_id = db.Column(db.Integer, nullable=False, server_default=db.text("0"))
    in_progress = db.Column(db.Boolean, nullable=False, server_default=db.text("false"))
    complete = db.Column(db.Boolean, nullable=False, server_default=db.text("false"))


class PuffleGuideCollection(AbstractDataCollection):
    __model__ = PuffleGuide
    __indexby__ = 'id'
    __filterby__ = 'id'

class PenguinPuffleGuideCollection(AbstractDataCollection):
    __model__ = PenguinPuffleGuide
    __indexby__ = 'penguin_id'
    __filterby__ = 'penguin_id'
