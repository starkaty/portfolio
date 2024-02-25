# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://docs.scrapy.org/en/latest/topics/item-pipeline.html


# useful for handling different item types with a single interface
from itemadapter import ItemAdapter
from pymongo import MongoClient
from pymongo.errors import DuplicateKeyError


class ParserBooksPipeline:
    def __init__(self):
        client = MongoClient('localhost:27017')
        self.mongo_db = client.parser_books

    def process_item(self, item, spider):
        collection = self.mongo_db[spider.name]
        collection.insert_one(item)
        return item

