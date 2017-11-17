前端开发流程：

# 为什么引入前端构建

- 静态资源文件的缓存
- 依赖关系
- 性能优化：文件合并与压缩
- 单元测试、代码分析 比如：Grunt、 gulp、webpack: front-end build systems

提高工作效率

# Gulp [王德水]（<http://deshui.wang/）>

- 脚本例子：

```js
gulp.task('default',function(){
return gulp
      .src("\\*\*/\*.js")
      .pipe(jshint())
      .pipe(concat())
      .pipe(uglify())
      .pipe(gulp.dest('./build/'))
})
```

- API：

  - gulp.task(name [, deps, fn])：注册一个task, name 是task的名字，deps是可选项，就是这个task依赖的tasks, fn是task要执行的函数

    ```js
    gulp.task('js', ,['jscs', 'jshint'], function(){
     return gulp
        .src('./src/**/*.js')
        .pipe(concat('alljs'))
        .pipe(uglify())
        .pipe(gulp.dest('./build/'));
    });
    说明：jscs和jshint先运行，随后再运行js的task.jscs和jshint是并行执行的，而不是顺序执行
    ```

  - gulp.src：构建源文件

    ```js
    gulp.src(['client/*.js', '!client/b*.js', 'client/c.js'])   # !是排除某些文件

    gulp.task('js',['jscs', 'jshint'],function(){
     return gulp
        .src('./src/**/*.js', {base:'./src/'})
        .pipe(uglify())
        .pipe(gulp.dest('./build/'));

    });
    // 说明：options.base 是指多少路径被保留，比如上面的 ./src/users/list.js 会被输出到 ./build/users/list.js
    ```

  - gulp.dest(path[, options]) 就是最终文件要输出的路径，options一般不用 - gulp.watch(glob [, opts], tasks) or gulp.watch(glob [, opts, cb]) 就是监视文件的变化，然后运行指定的Tasks或者函数

    ```js
    gulp.task('watch-js', function(){
      gulp.watch('./src/**/*.js',['jshint','jscs']);
    });

    gulp.task('watch-less', function(){
      gulp.watch('./src/**/*.less',function(event){
        console.log('less event'+event.type+' '+event.path)
      });
    });
    ```

#### 实例

```js
npm install gulp -g
npm install gulp --save-dev
var gulp = require('gulp');
var concat = require('gulp-concat');
var stripDebug = require('gulp-strip-debug');
var uglify = require('gulp-uglify');
var autoprefix = require('gulp-autoprefixer');
var minifyCSS = require('gulp-minify-css');

gulp.task('scripts', function() {
  gulp.src(['./src/scripts/*.js'])
    .pipe(concat('all.js'))
    .pipe(stripDebug())
    .pipe(uglify())
    .pipe(gulp.dest('./build/scripts/'));
});

// CSS concat, auto-prefix and minify
gulp.task('styles', function() {
  gulp.src(['./src/styles/*.css'])
    .pipe(concat('styles.css'))
    .pipe(autoprefix('last 2 versions'))
    .pipe(minifyCSS())
    .pipe(gulp.dest('./build/styles/'));
});

// default gulp task
gulp.task('default', [ 'scripts', 'styles'], function() {

// watch for JS changes
gulp.watch('./src/scripts/*.js', function() {
    gulp.run('jshint', 'scripts');
  });
// watch for CSS changes
    gulp.watch('./src/styles/*.css', function() {
        gulp.run('styles');
  });
});
gulp scripts
```

# 合并

大多数JavaScript和CSS都会在多个web页面中共享。因此，你很可能会将这些内容放到单独的.js和.css文件中，然后在web页面中引用这些文件。这种方式的结果是，用户的浏览器为了完全显示你的web引用，需要分别发送一个HTTP请求，以获取这些文件（或者至少需要验证一下这些文件是否已经改变了）。HTTP请求的代价是很高的。除了请求本身的大小之外，你还将因为网络延迟、HTTP头和Cookie等内容买单。合并与压缩工具的设计目的就是减少、乃至完全消除这些请求所带来的影响。

- 合并：多个JavaScript或CSS文件将被并入一个单一的JavaScript或CSS文件中。能够消除很大一部分HTTP请求的开销
- 压缩：够将JavaScript和CSS代码以尽可能最小的形式进行压缩，同时保证功能不变。 压缩能够极大的改进网络性能，因为它减少了每个HTTP响应的字节数

  - JavaScript：意味着将变量重命名为无意义的单字符形式，并且去除所有空白和格式符
  - CSS：由于页面风格依赖于变量的名称，因此通常来说只会去除格式符与空白

# webpack见代码仓库

```shell
sudo npm install -g webpack
sudo npm install -g webpack-dev-server
```

- Loaders:相当于task
- Preloader就是在调用loader之前需要调用的loader, 他不做任何代码的转换，只是进行检查。

- 生成多个文件

var path=require('path');

```js
module.exports = {
    context: path.resolve('js'),
    entry: {
        utils:'./utils.js',
        main:'./main.js'
    },
    output: {
        path: path.resolve('build/js/'),
        publicPath:'/public/assets/js/',
        filename: '[name].js'
    },
    devServer: {
        contentBase: 'views'
    },
    module: {
        preLoaders: [
            {
                test: /\.js$/,
                exclude: /node_modules/,
                loader: 'jshint'
            }
        ],

        loaders: [
            {
                test: /\.js$/,
                exclude: /node_modules/,
                loader: 'babel',
                query: {
                    presets: [
                        'es2015'
                    ]
                }
            },
            {
                test: /\.less$/,
                exclude: /node_modules/,
                loader: 'style!css!less'
            },
            {
                test: /\.(jpg|jpeg|png|gif)$/,
                include: /images/,
                loader: 'url'
            }

        ]
    },

    jshint:{
            "failOnHint": true,
            'esnext': true,
        }
};
```
