import scrapy
from scrapy.http import HtmlResponse
from auth_test.items import AuthTestItem
from time import sleep
from scrapy.loader import ItemLoader


class ToscrapeComSpider(scrapy.Spider):
    name = "toscrape_com"
    allowed_domains = ["quotes.toscrape.com"]
    start_urls = ['http://quotes.toscrape.com/']
    login_link = "http://quotes.toscrape.com/login"
    csrf_token = "//form/input[@name='csrf_token']/@value"
    user_login = 'admin'
    pwd = 'admin'
    element = '//span[@class="text"]/text()'

    def parse(self, response: HtmlResponse):
        yield scrapy.FormRequest(
            self.login_link,
            method='POST',
            callback=self.parse_text,
            formdata={'username':self.user_login, 'password':self.pwd},
            headers={'csrf_token': response.xpath(self.csrf_token).get()}
        )

    def parse_text(self, response: HtmlResponse):
        loader = ItemLoader(item=AuthTestItem(), response=response)
        loader.add_xpath('text', self.element)
        yield loader.load_item()

