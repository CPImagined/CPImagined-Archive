from houdini.data import AbstractDataCollection, db


class Postcard(db.Model):
    __tablename__ = 'postcard'

    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50), nullable=False)
    cost = db.Column(db.Integer, nullable=False, server_default=db.text("10"))
    enabled = db.Column(db.Boolean, nullable=False, server_default=db.text("false"))


class PenguinPostcard(db.Model):
    __tablename__ = 'penguin_postcard'

    id = db.Column(db.Integer, primary_key=True,
                   server_default=db.text("nextval('\"penguin_postcard_id_seq\"'::regclass)"))
    penguin_id = db.Column(db.ForeignKey('penguin.id', ondelete='CASCADE', onupdate='CASCADE'), nullable=False,
                           index=True)
    sender_id = db.Column(db.ForeignKey('penguin.id', ondelete='CASCADE', onupdate='CASCADE'), index=True)
    postcard_id = db.Column(db.ForeignKey('postcard.id', ondelete='CASCADE', onupdate='CASCADE'), nullable=False)
    send_date = db.Column(db.DateTime, nullable=False, server_default=db.text("now()"))
    details = db.Column(db.String(255), nullable=False, server_default=db.text("''::character varying"))
    has_read = db.Column(db.Boolean, nullable=False, server_default=db.text("false"))


class PostcardCollection(AbstractDataCollection):
    __model__ = Postcard
    __indexby__ = 'id'
    __filterby__ = 'id'


class SpecialPostcard(db.Model):
    __tablename__ = 'special_postcard'

    id = db.Column(db.Integer, primary_key=True)
    postcard_id = db.Column(db.ForeignKey('postcard.id', ondelete='CASCADE', onupdate='CASCADE'), nullable=False, index=True)
    start_date = db.Column(db.DateTime, nullable=False)
    end_date = db.Column(db.DateTime, nullable=False)
    sender_id = db.Column(db.ForeignKey('penguin.id', ondelete='CASCADE', onupdate='CASCADE'), index=True)


class SpecialPostcardCollection(AbstractDataCollection):
    __model__ = SpecialPostcard
    __indexby__ = 'id'
    __filterby__ = 'id'
    

class PenguinSpecialPostcard(db.Model):
    __tablename__ = 'penguin_special_postcard'

    penguin_id = db.Column(db.ForeignKey('penguin.id', ondelete='CASCADE', onupdate='CASCADE'),
                           primary_key=True, nullable=False)
    special_postcard_id = db.Column(db.ForeignKey('special_postcard.id', ondelete='CASCADE', onupdate='CASCADE'),
                                    primary_key=True, nullable=False)


class PenguinSpecialPostcardCollection(AbstractDataCollection):
    __model__ = PenguinSpecialPostcard
    __indexby__ = 'special_postcard_id'
    __filterby__ = 'penguin_id'