# The Art of Unix Programming

## 模块性：保持清晰和简洁

* 胶合层
    - 同时进行，一会顶层，一会底层，来来回回的开发——说白了就是在开发中不断的重构，边开发边理解边沉淀
    - 需要一层胶合层来胶合业务逻辑层和底层原语层（软件开发中的业务层和技术层的胶合），Unix的设计哲学认为，这层胶合层应该尽量地薄，胶合层越多，我们就只能在其中苦苦挣扎
    - 胶合层原则就是分离原则上更为上层地体现，策略（业务逻辑）和机制（基础技术或原语）的清楚的分离。你可以看到，OO和Unix都是在做这样的分离。但是需要注意到的时，OO用抽象接口来做这个分离——很多OO的模式中，抽象层太多了，导致胶合层太过于复杂了，也就是说，OO鼓励了——“厚重地胶合和复杂层次”，反而增加了程序的复杂度（这种情况在恶化中）。而Unix采用的是薄的胶合层，薄地相当的优雅
    - OO的最大的问题就——接口复杂度太高，胶合层太多

## 哲学

Rule of Modularity: Write simple parts connected by clean interfaces.
Rule of Clarity: Clarity is better than cleverness.
Rule of Composition: Design programs to be connected to other programs.
Rule of Separation: Separate policy from mechanism; separate interfaces from engines.
Rule of Simplicity: Design for simplicity; add complexity only where you must.
Rule of Parsimony: Write a big program only when it is clear by demonstration that nothing else will do.
Rule of Transparency: Design for visibility to make inspection and debugging easier.
Rule of Robustness: Robustness is the child of transparency and simplicity.
Rule of Representation: Fold knowledge into data so program logic can be stupid and robust.
Rule of Least Surprise: In interface design, always do the least surprising thing.
Rule of Silence: When a program has nothing surprising to say, it should say nothing.
Rule of Repair: When you must fail, fail noisily and as soon as possible.
Rule of Economy: Programmer time is expensive; conserve it in preference to machine time.
Rule of Generation: Avoid hand-hacking; write programs to write programs when you can.
Rule of Optimization: Prototype before polishing. Get it working before you optimize it.
Rule of Diversity: Distrust all claims for “one true way”.
Rule of Extensibility: Design for the future, because it will be here sooner than you think.

## X Windows 的设计者 Mike Gancarz 给出了下面九条哲学思想

Small is beautiful.
Make each program do one thing well.
Build a prototype as soon as possible.
Choose portability over efficiency.
Store data in flat text files.
Use software leverage to your advantage.
Use shell scripts to increase leverage and portability.
Avoid captive user interfaces.
Make every program a filter.
