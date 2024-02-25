import scrapy
from scrapy.http import HtmlResponse
from time import sleep
from parser_books.items import ParserBooksItem

#Создадим парсер для сайта labirint.ru, который будет помещать в базу данных mongodb данные о книгах-сказках в наличии(название, автор, цена книги, издательство, ссылка)
class LabirintRuSpider(scrapy.Spider):
    name = "labirint_ru"
    allowed_domains = ["labirint.ru"]
    start_urls = ["https://www.labirint.ru/search/%D1%81%D0%BA%D0%B0%D0%B7%D0%BA%D0%B8/?stype=0&available=1"]

    def parse(self, response:HtmlResponse):
        next_page = response.xpath('//div/a[@title="Следующая"]/@href').get()
        if next_page:
            sleep(1)
            yield response.follow(next_page, callback=self.parse)

        link_list = response.xpath('//a[@class="product-title-link"]/@href').getall()
        for link in link_list:
            yield response.follow(link, callback=self.parse_book)

    def parse_book(self, response:HtmlResponse):
        book_name = response.xpath('//div[@id="product-title"]/h1/text()').get()
        book_link = response.url
        book_authors = response.xpath('//div[@class="authors"]/a[@class ="analytics-click-js"]/text()').getall()
        book_price = response.xpath('//span[@class="buying-pricenew-val-number"]/text()').get() if response.xpath('//span[@class="buying-pricenew-val-number"]/text()').get() else response.xpath('//span[@class="buying-price-val-number"]/text()').get()
        book_price_currency = response.xpath('//span[@class="buying-pricenew-val-currency"]/text()').get()
        book_publisher = response.xpath('//div[@class="publisher"]/a/text()').get()

        yield ParserBooksItem(
            # define the fields for your item here like:
            name = book_name,
            authors = book_authors,
            price = int(book_price),
            currency = book_price_currency,
            publisher = book_publisher,
            link = book_link)







