目录结构:

scrapy.cfg              # 部署Scrapy爬虫的配置文件
demo123/                # 外层目录
    __init__.py         # 初始化脚本
    items.py            # Items 代码模板(继承类),用来存放爬虫爬取下来数据的模型。       需要爬取的数据
    pipelines.py        # Pipelines 代码模板(继承类),用来将items的模型存储到本地磁盘中。爬到数据后的处理
    spiders/            # Spiders 代码模板目录
    __pycache__/
    middlewares.py      # Middlewares 代码模板(继承类),用来存放各种中间件的文件。       如:IP代理,反爬机制等
    settings.py         # 爬虫的配置文件,（比如请求头、多久发送一次请求、ip代理池等）。



scrapy使用方式:
    1.建立scrapy爬虫工程
        scrapy startproject demo123
    2.在工程文件中产生一个scrapy爬虫
        scrapy genspider demo python123.io(需要爬取的网页)     # 用于生成demo.py,也可以手工生成
        1) 生成一个名称为demo的spider
        2) 在spiders目录下增加代码文件demo.py,生成的代码parse()用于处理响应,加息内容形成字典,发现新的URL继续爬取
    3.配置产生的spider爬虫
        1) 初始化URL
        2) 获取页面后的结息方式
    4.运行爬虫
        scrapy crawl demo

