from houdini.data import AbstractDataCollection, db


class Outfit(db.Model):
    __tablename__ = 'penguin_outfits' 

    id = db.Column(db.Integer, primary_key=True)
    player_id = db.Column(db.ForeignKey('penguin.id', ondelete='CASCADE', onupdate='CASCADE'), nullable=False)
    outfit_data = db.Column(db.String, nullable=False, server_default=db.text("'{}'::json"))


class OutfitCollection(AbstractDataCollection):
    __model__ = Outfit
    __indexby__ = 'id'
    __filterby__ = 'id'
