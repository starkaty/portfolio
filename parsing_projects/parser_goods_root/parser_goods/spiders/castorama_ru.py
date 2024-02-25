import scrapy
from scrapy.http import HtmlResponse
from parser_goods.items import ParserGoodsItem
from time import sleep
from scrapy.loader import ItemLoader


class CastoramaRuSpider(scrapy.Spider):
    name = 'castorama_ru'
    allowed_domains = ['castorama.ru']
    start_urls = ['https://www.castorama.ru/catalogsearch/result/?arrFilter_P7_MIN=490&arrFilter_P7_MAX=2000&set_filter=Y&q=%D1%88%D0%BA%D0%B0%D1%84&PAGEN_3=1']

    def parse(self, response:HtmlResponse):
        next_page = response.xpath('//a[@class="next i-next"]/@href').get()
        if next_page:
            sleep(1)
            yield response.follow(next_page, callback=self.parse)

        links = response.xpath('//a[@class="product-card__img-link"]/@href').getall()
        for link in links:
            yield response.follow(link, callback=self.parse_good)

    def parse_good(self, response:HtmlResponse):
        loader = ItemLoader(item=ParserGoodsItem(), response=response)

        missing_goods = response.xpath('//span[@class="add-to-cart__not-saleable-message"]').get()
        if not missing_goods:
            loader.add_xpath('name', '//h1[@class="product-essential__name hide-max-small"]/text()')
            loader.add_value('link', response.url)
            loader.add_xpath('photos', '//li/img/@data-src')
            loader.add_xpath('price', '//span[@class="price"]/span/span[1]/text()')
            yield loader.load_item()
