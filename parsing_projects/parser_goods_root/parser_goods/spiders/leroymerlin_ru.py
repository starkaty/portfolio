# import scrapy
# from scrapy.http import HtmlResponse
# from time import sleep
#
#
# class LeroymerlinRuSpider(scrapy.Spider):
#     name = "leroymerlin_ru"
#     allowed_domains = ["leroymerlin.ru"]
#     start_urls = ["https://leroymerlin.ru/search/?q=крепление+для+душа"]
#
#
#     def parse(self, response:HtmlResponse):

        # next_page = response.xpath('//a[@class="bex6mjh_plp s15wh9uj_plp l7pdtbg_plp r1yi03lb_plp sj1tk7s_plp"]/@href').get()
        # if next_page:
        #     sleep(1)
        #     yield response.follow(next_page, callback=self.parse)
        #
        # links = response.xpath('//a[@class="bex6mjh_plp b1f5t594_plp iypgduq_plp nf842wf_plp"]')
        # for link in links:
        #     print('@@@@@@@@@@@@@@@@@@',link)
        #     yield response.follow(link, callback=self.parse_good)

    # def parse_good(self, response:HtmlResponse):
    #     name = response.xpath('//h1/span[@class="t12nw7s2_pdp"]/text()').get()
    #     link = response.url
    #     photos_links = response.xpath('//img[@slot="thumbs"]/@src').getall()
    #     price = response.xpath('//span[@slot="price"][1]/text()').get()
    #
    #     print('**********************************', name, link, photos_links, price)



# 1) Взять любую категорию товаров на сайте Леруа Мерлен. Собрать следующие данные:
# ● название;
# ● все фото;
# ● ссылка;
# ● цена.
#
# Реализуйте очистку и преобразование данных с помощью ItemLoader. Цены должны быть в виде числового значения.
#
# Дополнительно:
# 2)Написать универсальный обработчик характеристик товаров, который будет формировать данные вне зависимости от их типа и количества.
# 3)Реализовать хранение скачиваемых файлов в отдельных папках, каждая из которых должна соответствовать собираемому товару



