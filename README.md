# minimizeViewControllerDemo
minimizeViewControllerDemo


## Intro

一般来说我们想要展示一个VC，需要执行下面的语句

```
OMCPlayingViewController *playingVC = [[OMCPlayingViewController alloc] init];
[self presentViewController:playingVC animated:YES completion:nil];
```

当你在`OMCPlayingViewController`里面点击返回的时候，我们需要把这个页面dismiss掉：

```
[self dismissViewControllerAnimated:YES completion:nil];
```

这样，这个VC就被dismiss并销毁了。

但是，有些时候（比如播放页面），我们需要最小化当前页面，也就是dismiss，但是并不销毁该VC。

同时在App中提供一处入口，点击恢复显示该页面。

实现类似下图所示的效果：

![enter image description here](https://github.com/creeveliu/minimizeViewControllerDemo/blob/master/QQ20170430-163220.gif)


如何最合理的实现该效果呢？

## 实现思路

dismiss一个VC后，VC是否会被销毁，取决于，除presenting VC之外还有没有其他对象强引用了这个VC。而我们要实现dismiss后不销毁的最小化功能，而且需要提供一个全局的入口，恢复显示该页面，最合理的显然是通过単例来强引用这个VC。

## 实现方法

首先我们需要新建一个単例`OMCPlayingManager`。
単例里面强引用一个对象`playingVC`:
```
@property (nonatomic, strong) OMCPlayingViewController *playingVC;
```

然后overwrite `OMCPlayingViewController`的init方法：
```
- (instancetype)init
{
    self = [super init];
    if (self) {
        [OMCPlayingManager sharedManager].playingVC = self;
    }
    return self;
}
```

然后再在OMCPlayingViewController里面实现两个方法，一个是销毁VC，一个是最小化VC：

```
// 退出并销毁VC

    [self dismissViewControllerAnimated:YES completion:^{
        [OMCPlayingManager sharedManager].playingVC = nil;
    }];
```


```
// 最小化VC
    [self dismissViewControllerAnimated:YES completion:nil];
```

退出并销毁VC部分的代码，需要手动将`[OMCPlayingManager sharedManager].playingVC`赋值为nil，解除强引用，否则由于単例强引用了VC，playingVC不会调用dealloc方法销毁对象。这也刚好符合我们最小化VC的需求。

最小化之后，我们就可以通过`[OMCPlayingManager sharedManager].playingVC`来获取到这个已经不在界面上显示，但内存中还存在的VC了。

我们可以在其他页面中KVO単例的`playingVC`来实现页面添加一个播放VC的入口。

PS：在PlayingVC最小化的时候，present一个新的PlayingVC，会不会销毁原来的PlayingVC呢？会，由于`init`方法里面会重新给単例的`playingVC`属性赋值，所以之前的VC会因为没有其他对象的强引用而销毁。这也避免了我们重复创建VC导致的内存泄漏。
