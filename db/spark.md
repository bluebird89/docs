# [spark](https://github.com/apache/spark)

a fast and general cluster computing system for Big Data. It provides high-level APIs in Scala, Java, Python, and R, and an optimized engine that supports general computation graphs for data analysis. It also supports a rich set of higher-level tools including Spark SQL for SQL and DataFrames, MLlib for machine learning, GraphX for graph processing, and Spark Streaming for stream processing.

## 安装

* 通过Python 用pyspark命令进行唤醒
* 通过Scala spark-shell
* 在jupyter notebook当中配置Scala和Pyspark

```sh
sudo tar -zvxf spark-3.0.0-preview2-bin-hadoop2.7.tgz

sudo mv ~/Downloads/spark-3.0.0-preview2-bin-hadoop2.7 /usr/local/

# ~/.zshrc
export SPARK_HOME=/usr/local/spark-3.0.0-bin-hadoop2.7
export PATH=$PATH:$SPARK_HOME/bin
export PYSPARK_PYTHON=python3

source ~/.zshrc
pyspark

# 安装jupyter下Scala内核Toree, 打开点击添加，可以发现选择的内核多了一个
pip install toree
jupyter toree install --spark_home=$SPARK_HOME

# pyspark的配置
export PYSPARK_DRIVER_PYTHON=jupyter
export PYSPARK_DRIVER_PYTHON_OPTS=notebook
# 只需要在终端输入pyspark就会自动为我们开启一个新的jupyter网页。我们选择Python3的内核新建job就可以使用pyspark
```

## 图书

* 《Spark大数据处理：技术、应用》，机械工业出版社
* 《Learning Spark: Lightning-Fast Big Data Analysis》 Holden Karau, Andy Kowinski, Mark Hamstra, Matei Zaharia
