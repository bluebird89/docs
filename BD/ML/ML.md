# Machine learning

- 机器学习意味着：从数据中学习
- 主要关乎算法与数据，尤其是数据;:可以没有复杂的算法，但不能没有好的数据。
- 除非你有许多数据，否则你应该坚持使用简单的模型:基于数据识别模式，构建由参数定义的模型。如果你的参数定义过多，你很容易过度拟合。详细的解释需要更多数学知识，但是机器学习的原则是：尽可能使模型简单。
- 机器学习的性能受到输入数据质量限制:"无用输入，无用输出"巧妙地点明了机器学习的关键，机器学习只能发现输入数据中的模式。对于有监督的机器学习任务，例如分类，输入数据必须标记正确，特征明显。
- 机器学习需要具有代表性的数据:过去的表现不对未来结果作保证。机器学习则只能对与训练数据分布相同的样本外有良好效果。因此，应对训练数据和样本外数据的偏离表示警觉，经常性地重新训练你的模型以免失效。
- 机器学习中大部分的困难工作为数据转换:用于数据清洗和特征工程（将原始特征转化为更有代表性的特征）上。
- 深度学习将一些传统需要特征工程的工作自动化进行，特别是在图像和视频领域。但是深度学习并不是一种新技术，仍然需要在数据清理和转化方面付出巨大的努力。
- 机器学习系统极易受操作者误差影响:机器学习算法不会杀死人，只有人会杀死人。当机器学习算法系统奔溃时，一般很少是由于机器学习算法错误。而是因为大多数时候，你在训练数据中引进了人为误差，或者一些系统误差。所以，永远保持质疑。
- 机器学习可以漫不尽心地创造自我实现的预言:你今天做的决定将影响明天收集的训练数据。一旦机器学习系统中嵌入偏差，它就会生成更多新的数据强化这些偏差，有一些偏差会毁掉人的生活。负责任一点：不要创造可自我实现的预言。
- AI不会拥有自我意识，不用担心崛起并毁灭人类

## 资源

- [tensorflow/tensor2tensor](https://github.com/tensorflow/tensor2tensor)
- [josephmisiti/awesome-machine-learning](https://github.com/josephmisiti/awesome-machine-learning)A curated list of awesome Machine Learning frameworks, libraries and software.
- [scikit-learn/scikit-learn](https://github.com/scikit-learn/scikit-learn)scikit-learn: machine learning in Python <http://scikit-learn.org>
- [ZuzooVn/machine-learning-for-software-engineers](https://github.com/ZuzooVn/machine-learning-for-software-engineers):A complete daily plan for studying to become a machine learning engineer.
- [airbnb/aerosolve](https://github.com/airbnb/aerosolve):A machine learning package built for humans. http://airbnb.github.io/aerosolve/
- [scikit-learn/scikit-learn](https://github.com/scikit-learn/scikit-learn):scikit-learn: machine learning in Python http://scikit-learn.org
- [fchollet/keras](https://github.com/fchollet/keras):Deep Learning library for Python. Runs on TensorFlow, Theano, or CNTK. http://keras.io/

## 教程

* [learnml/machine-learning-specialization](https://github.com/learnml/machine-learning-specialization)
* [ICT-BDA/EasyML](https://github.com/ICT-BDA/EasyML):Easy Machine Learning is a general-purpose dataflow-based system for easing the process of applying machine learning algorithms to real world tasks.
* [kubeflow/kubeflow](https://github.com/kubeflow/kubeflow):Machine Learning Toolkit for Kubernetes 
