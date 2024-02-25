# Define here the models for your scraped items
#
# See documentation in:
# https://docs.scrapy.org/en/latest/topics/items.html

import scrapy
from itemloaders.processors import MapCompose, Compose, TakeFirst

def clean_name(name):
    try:
        name = name[0].replace('\n', '').replace('      ','').replace('  ', '')
    except:
        return name
    return name

def clean_price(price):
    try:
        price = int(price[0])
    except:
        try:
            price = int(price[0].replace(' ', ''))
        except:
            return price
    return price

def clean_link(link):
    try:
        link = link[0]
    except:
        return link
    return link

def clean_photos(photos):
    try:
        photos = ['https://www.castorama.ru'+el for el in photos]
    except:
        return photos
    return photos

class ParserGoodsItem(scrapy.Item):
    # define the fields for your item here like:
    name = scrapy.Field(input_processor=Compose(clean_name), output_processor=TakeFirst())
    link = scrapy.Field(input_processor=Compose(clean_link), output_processor=TakeFirst())
    photos = scrapy.Field(input_processor=Compose(clean_photos))
    price = scrapy.Field(input_processor=Compose(clean_price), output_processor=TakeFirst())
    _id = scrapy.Field()
